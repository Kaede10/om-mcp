from mcp.server.fastmcp import FastMCP
from tools.health import COMMUNITY_MAP


def register(mcp: FastMCP):

    @mcp.tool()
    async def list_communities() -> str:
        """列出所有支持查询的社区名称。"""
        # 去重，按字母排序展示 API 侧的实际社区名
        communities = sorted(set(COMMUNITY_MAP.values()))
        lines = ["支持查询的社区列表："]
        for c in communities:
            lines.append(f"  - {c}")
        return "\n".join(lines)
