import httpx

# 统一使用远程 API 地址
API_BASE_URL = "https://datastat.osinfra.cn/server"


async def get(path: str, params: dict = None, base_url: str = API_BASE_URL) -> dict:
    try:
        async with httpx.AsyncClient(timeout=30) as client:
            resp = await client.get(f"{base_url}{path}", params=params)
            resp.raise_for_status()
            return resp.json()
    except httpx.HTTPStatusError as e:
        return {"code": -1, "message": f"HTTP {e.response.status_code}：接口暂不可用", "data": None}
    except Exception as e:
        return {"code": -1, "message": str(e), "data": None}


async def post(path: str, body: dict = None, base_url: str = API_BASE_URL) -> dict:
    try:
        async with httpx.AsyncClient(timeout=30) as client:
            resp = await client.post(f"{base_url}{path}", json=body or {})
            resp.raise_for_status()
            return resp.json()
    except httpx.HTTPStatusError as e:
        return {"code": -1, "message": f"HTTP {e.response.status_code}：接口暂不可用", "data": None}
    except Exception as e:
        return {"code": -1, "message": str(e), "data": None}


def extract_data(result: dict):
    """统一提取 data 字段，兼容双层嵌套结构。"""
    data = result.get("data")
    if isinstance(data, dict) and "code" in data and "data" in data:
        return data.get("data")
    return data
