#!/usr/bin/env python3
"""调试健康度查询接口，打印每一步的详细信息"""
import httpx
import asyncio
import json

API_BASE_URL = "https://datastat.osinfra.cn/server"

async def debug_health_query(community: str):
    """调试健康度查询"""
    print("=" * 80)
    print(f"开始查询社区: {community}")
    print("=" * 80)

    # 构建请求
    path = f"/health/{community}/metric"
    params = {"mode": "general"}
    url = f"{API_BASE_URL}{path}"

    print(f"\n[步骤1] 构建请求")
    print(f"  - 基础URL: {API_BASE_URL}")
    print(f"  - 路径: {path}")
    print(f"  - 完整URL: {url}")
    print(f"  - 查询参数: {params}")

    try:
        print(f"\n[步骤2] 发送 HTTP GET 请求...")
        async with httpx.AsyncClient(timeout=30) as client:
            resp = await client.get(url, params=params)

            print(f"\n[步骤3] 收到响应")
            print(f"  - 状态码: {resp.status_code}")
            print(f"  - 响应头: {dict(resp.headers)}")

            print(f"\n[步骤4] 解析响应体")
            try:
                result = resp.json()
                print(f"  - 响应JSON:")
                print(json.dumps(result, indent=2, ensure_ascii=False))
            except Exception as e:
                print(f"  - JSON解析失败: {e}")
                print(f"  - 原始响应文本: {resp.text[:500]}")
                return

            print(f"\n[步骤5] 检查响应结构")
            print(f"  - code字段: {result.get('code')}")
            print(f"  - message字段: {result.get('message')}")
            print(f"  - data字段存在: {('data' in result)}")

            if result.get('code') != 1:
                print(f"\n[结果] API返回错误")
                print(f"  - 错误信息: {result.get('message', '未知错误')}")
            elif not result.get('data'):
                print(f"\n[结果] 社区暂无健康度数据")
            else:
                print(f"\n[结果] 查询成功")
                data = result.get('data')
                print(f"  - 综合评分: {data.get('avg_score')}")
                print(f"  - 数据日期: {data.get('created_at')}")

    except httpx.HTTPStatusError as e:
        print(f"\n[错误] HTTP状态错误")
        print(f"  - 状态码: {e.response.status_code}")
        print(f"  - 响应文本: {e.response.text[:500]}")
    except Exception as e:
        print(f"\n[错误] 请求异常")
        print(f"  - 异常类型: {type(e).__name__}")
        print(f"  - 异常信息: {str(e)}")

async def main():
    # 测试不同的社区名称
    test_cases = [
        "openEuler",  # 标准大小写
        "openeuler",  # 全小写
        "OPENEULER",  # 全大写
    ]

    for community in test_cases:
        await debug_health_query(community)
        print("\n")

if __name__ == "__main__":
    asyncio.run(main())
