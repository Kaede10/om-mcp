#!/usr/bin/env python3
"""测试日期格式转换功能"""
import asyncio
from tools.health import register
from mcp.server.fastmcp import FastMCP

async def main():
    mcp = FastMCP('test')
    register(mcp)

    print("=" * 60)
    print("测试日期格式: 2026-3-5")
    print("=" * 60)
    result = await mcp._tool_manager._tools['get_community_health'].fn('openEuler', '2026-3-5')
    print(result)
    print()

    print("=" * 60)
    print("测试日期格式: 2026-03-05")
    print("=" * 60)
    result = await mcp._tool_manager._tools['get_community_health'].fn('openEuler', '2026-03-05')
    print(result)
    print()

    print("=" * 60)
    print("测试不带日期参数（获取最新数据）")
    print("=" * 60)
    result = await mcp._tool_manager._tools['get_community_health'].fn('openEuler', '')
    print(result)

if __name__ == '__main__':
    asyncio.run(main())
