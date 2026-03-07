import httpx

BASE_URL = "https://datastat.osinfra.cn"
MAGIC_API_BASE_URL = "http://localhost:9999"


async def get(path: str, params: dict = None, base_url: str = BASE_URL) -> dict:
    async with httpx.AsyncClient(timeout=30) as client:
        resp = await client.get(f"{base_url}{path}", params=params)
        resp.raise_for_status()
        return resp.json()


async def post(path: str, body: dict = None, base_url: str = MAGIC_API_BASE_URL) -> dict:
    async with httpx.AsyncClient(timeout=30) as client:
        resp = await client.post(f"{base_url}{path}", json=body or {})
        resp.raise_for_status()
        return resp.json()


def extract_data(result: dict):
    """MagicAPI 有时返回双层 data 嵌套（脚本内 return {...} 包着外层 wrapper），统一提取。"""
    data = result.get("data")
    if isinstance(data, dict) and "code" in data and "data" in data:
        return data.get("data")
    return data
