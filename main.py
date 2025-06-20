import asyncio
import json
import requests
import time
import os
from aiohttp import web, WSMsgType
import aiohttp_cors
from jinja2 import Environment, FileSystemLoader

# Global variables
clients = {}
datas = {}
jobid_server = {}

try:
    with open("image_convert.json", "r") as f:
        image_convert = json.load(f)
except:
    image_convert = {}

def save_url():
    with open("image_convert.json", "w") as f:
        json.dump(image_convert, f, ensure_ascii=False, indent=4)

def get_img_batch(ids):
    """
    Gửi nhiều assetId cùng lúc để lấy URL ảnh.
    """
    try:
        joined_ids = ",".join(ids)
        res = requests.get(f"https://thumbnails.roblox.com/v1/assets?assetIds={joined_ids}&size=420x420&format=Png&isCircular=false")
        results = res.json().get("data", [])

        for item in results:
            image_convert[str(item["targetId"])] = item.get("imageUrl", "https://tr.rbxcdn.com/180DAY-0d8f901560f81338b125051326b08b5c/420/420/Image/Png/noFilter")
    except Exception as e:
        print("Error in batch fetch:", e)

def replace_ids_with_images(obj):
    if isinstance(obj, dict):
        new_obj = {}
        for key, value in obj.items():
            if isinstance(value, dict) and "id" in value:
                item = value.copy()
                asset_id = str(item["id"])
                item["id"] = image_convert.get(asset_id, asset_id)
                new_obj[key] = item
            else:
                new_obj[key] = replace_ids_with_images(value)
        return new_obj
    elif isinstance(obj, list):
        return [replace_ids_with_images(v) for v in obj]
    else:
        return obj

def collect_missing_ids(obj, missing_ids):
    if isinstance(obj, dict):
        for value in obj.values():
            if isinstance(value, dict) and "id" in value:
                missing_ids.add(str(value["id"]))
            else:
                collect_missing_ids(value, missing_ids)
    elif isinstance(obj, list):
        for item in obj:
            collect_missing_ids(item, missing_ids)

# HTTP Routes
async def index(request):
    converted_data = {}
    all_missing_ids = set()

    # Quét toàn bộ ID cần tải ảnh
    for user_data in datas.values():
        collect_missing_ids(user_data, all_missing_ids)

    # Gọi API nếu có ID chưa có ảnh
    if all_missing_ids:
        get_img_batch(list(all_missing_ids))
        save_url()

    # Thay ID bằng link ảnh
    for username, user_data in datas.items():
        converted_data[username] = replace_ids_with_images(user_data)

    # Render template (tạo template engine đơn giản)
    try:
        env = Environment(loader=FileSystemLoader('templates'))
        template = env.get_template('index.html')
        html = template.render(data=converted_data)
        return web.Response(text=html, content_type='text/html')
    except:
        # Fallback nếu không có template
        return web.json_response(converted_data)

async def execute_script(request):
    data = await request.json()
    script = data.get("script", "print('not found')")
    account = data.get("accounts", [])

    for acc in account:
        if acc not in clients:
            return web.json_response({"error": f"Account {acc} không có trong danh sách kết nối."}, status=400)

        try:
            ws = clients[acc]
            await ws.send_str(script)

        except Exception as e:
            print(f"❌ Lỗi khi gửi script cho {acc}: {e}")
            return web.json_response({"error": f"Lỗi khi gửi script cho {acc}: {e}"}, status=500)

    return web.json_response({"message": "Script executed successfully!"})

async def remove_account(request):
    data = await request.json()

    account = data.get("accounts", [])

    for acc in account:
        if acc in datas:
            del datas[acc]

        if acc in clients:
            del clients[acc]

    return web.json_response({"message": "ok"})

async def getjobid(request):
    data = await request.json()
    account = data.get("accounts", [])
    
    for acc in account:
        if acc not in clients:
            return web.json_response({"error": f"Account {acc} không có trong danh sách kết nối."}, status=400)
        
        try:
            ws = clients[acc]
            await ws.send_str("getjobid")

        except Exception as e:
            print(f"❌ Lỗi khi gửi getjobid cho {acc}: {e}")

    # Đợi response
    start = time.time()
    timeout = 10
    while time.time() - start < timeout:
        if all(acc in jobid_server for acc in account):
            break
        await asyncio.sleep(0.5)

    msg_out = "Kết quả trả về:\n"
    for acc in account:
        jobid = jobid_server.get(acc)
        if jobid:
            msg_out += f"{acc} => {jobid}\n"
        else:
            msg_out += f"{acc} => không nhận được jobid\n"

    # Xóa dữ liệu sau khi trả về
    for acc in account:
        jobid_server.pop(acc, None)

    return web.json_response({"text": msg_out})

# WebSocket Handler
async def websocket_handler(request):
    ws = web.WebSocketResponse()
    await ws.prepare(request)
    
    username = None
    
    try:
        async for msg in ws:
            if msg.type == WSMsgType.TEXT:
                if msg.data == 'ping':
                    await ws.send_str('pong')
                    continue
                    
                try:
                    data = json.loads(msg.data)
                    
                    # Xử lý kết nối đầu tiên
                    if "username" in data and username is None:
                        if data["username"] is not None:
                            username = data["username"]
                            clients[username] = ws
                            print(f"✅ {username} đã kết nối WebSocket.")
                        else:
                            print("❌ Không thể thiết lập username vì giá trị là None.")
                        continue
                    
                    # Xử lý các command khác
                    if data.get("command") == "updateData":
                        if username is not None:
                            datas[username] = data["data"]
                        else:
                            print("⚠️ Đã nhận updateData nhưng chưa có username.")

                    elif data.get("command") == "jobid":
                        if username is not None:
                            jobid_server[username] = data["data"]["jobid"]
                            print(f"[{username}] gửi jobid: {jobid_server[username]}")
                        else:
                            print("⚠️ Đã nhận jobid nhưng chưa có username.")
                    
                except json.JSONDecodeError:
                    print(f"Invalid JSON from {username}: {msg.data}")
                    
            elif msg.type == WSMsgType.ERROR:
                print(f'WebSocket error: {ws.exception()}')
                break
                
    except Exception as e:
        print(f"❌ Lỗi WebSocket với {username}: {e}")
    finally:
        if username and username in clients:
            clients.pop(username, None)
            print(f"❌ {username} đã ngắt kết nối.")
    
    return ws

# Setup app
async def create_app():
    app = web.Application()
    
    # Setup CORS
    cors = aiohttp_cors.setup(app, defaults={
        "*": aiohttp_cors.ResourceOptions(
            allow_credentials=True,
            expose_headers="*",
            allow_headers="*",
            allow_methods="*"
        )
    })
    
    # HTTP routes
    app.router.add_get('/', index)
    app.router.add_post('/execute_script', execute_script)
    app.router.add_post('/getjobid', getjobid)
    app.router.add_post('/remove_account',remove_account)
    
    # WebSocket route
    app.router.add_get('/ws', websocket_handler)
    
    # Add CORS to all routes
    for route in list(app.router.routes()):
        cors.add(route)
    
    # Static files (nếu cần)
    # app.router.add_static('/', path='static', name='static')
    
    return app

async def main():
    app = await create_app()
    
    print("🚀 Server starting on port 6336...")
    print("📍 HTTP: http://localhost:6336")
    print("📍 WebSocket: ws://localhost:6336/ws")
    
    runner = web.AppRunner(app)
    await runner.setup()
    site = web.TCPSite(runner, '0.0.0.0', 6336)
    await site.start()
    
    print("✅ Server is running!")
    
    # Keep running
    await asyncio.Future()

if __name__ == '__main__':
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\n🛑 Server stopped by user")