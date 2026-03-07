import json
from mcp.server.fastmcp import FastMCP
from lib.http import get, post, extract_data, MAGIC_API_BASE_URL


def register(mcp: FastMCP):

    @mcp.tool()
    async def get_community_list() -> str:
        """获取所有支持的开源社区列表。适用于 PPT 中展示社区全景图，或作为其他查询的前置步骤。"""
        result = await post("/server/community/list")
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = result.get("data", [])
        lines = [f"共 {len(data)} 个社区："]
        for c in data:
            lines.append(f"  - {c}")
        return "\n".join(lines)

    @mcp.tool()
    async def get_metric_dict() -> str:
        """获取指标字典，包含所有可用指标的名称、中文名、单位和定义。适用于 PPT 数据说明页。"""
        result = await get("/server/dict/metric", base_url=MAGIC_API_BASE_URL)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无指标数据"
        lines = ["指标字典："]
        for m in data:
            lines.append(f"  [{m.get('name')}] {m.get('name_zh')} — 单位：{m.get('unit')}，说明：{m.get('definition')}")
        return "\n".join(lines)

    @mcp.tool()
    async def get_project_hotspot() -> str:
        """获取最近更新的热点仓库列表（按更新时间倒序前10个）。适用于 PPT 展示社区近期热点动态。"""
        result = await get("/server/project/hotspot", base_url=MAGIC_API_BASE_URL)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无热点仓库数据"
        lines = [f"热点仓库 Top {len(data)}："]
        for i, repo in enumerate(data, 1):
            lines.append(f"  {i}. {repo.get('repo_name')} — 更新于 {repo.get('updated_at')} — {repo.get('html_url', '')}")
        return "\n".join(lines)

    @mcp.tool()
    async def get_project_repo_list() -> str:
        """获取仓库列表（最近更新的 50 个）。适用于 PPT 展示社区仓库规模总览。"""
        result = await get("/server/project/repolist", base_url=MAGIC_API_BASE_URL)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无仓库数据"
        lines = [f"仓库列表（共 {len(data)} 个）："]
        for repo in data:
            lines.append(f"  - {repo.get('repo_name')} | 创建：{repo.get('created_at')} | 更新：{repo.get('updated_at')}")
        return "\n".join(lines)

    @mcp.tool()
    async def get_project_active() -> str:
        """获取活跃仓库统计（总仓库数、活跃数、非活跃数）。适用于 PPT 展示社区整体活跃情况。"""
        result = await get("/server/project/active", base_url=MAGIC_API_BASE_URL)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无活跃项目数据"
        return (
            f"仓库活跃统计：\n"
            f"  总仓库数：{data.get('total_repos', 'N/A')}\n"
            f"  活跃仓库：{data.get('active_repos', 'N/A')}\n"
            f"  非活跃仓库：{data.get('inactive_repos', 'N/A')}"
        )

    @mcp.tool()
    async def get_project_topn_company_pr(community: str = "", start_time: str = "", end_time: str = "") -> str:
        """获取 PR 贡献企业 Top N 排名（贡献数量和占比）。适用于 PPT 展示企业贡献分布饼图/条形图数据。

        Args:
            community: 社区名称（可选）
            start_time: 开始时间，格式 YYYY-MM-DD（可选）
            end_time: 结束时间，格式 YYYY-MM-DD（可选）
        """
        body = {}
        if community:
            body["community"] = community
        if start_time:
            body["start_time"] = start_time
        if end_time:
            body["end_time"] = end_time

        result = await post("/server/project/topn/company/pr", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无企业 PR 贡献数据"
        lines = ["企业 PR 贡献 Top 排名："]
        for i, item in enumerate(data, 1):
            lines.append(f"  {i}. {item.get('company')} — {item.get('count')} 个 PR（占比 {item.get('percentage')}%）")
        return "\n".join(lines)

    @mcp.tool()
    async def get_company_count(community: str = "", start_time: str = "", end_time: str = "") -> str:
        """获取社区参与的组织/企业数量统计。

        Args:
            community: 社区名称（可选）
            start_time: 开始时间，格式 YYYY-MM-DD（可选）
            end_time: 结束时间，格式 YYYY-MM-DD（可选）
        """
        body = {}
        if community:
            body["community"] = community
        if start_time:
            body["start_time"] = start_time
        if end_time:
            body["end_time"] = end_time

        result = await post("/server/project/topn/company/pr", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无组织数据"

        companies = data if isinstance(data, list) else []
        return f"参与贡献的组织/企业总数：{len(companies)}"

    @mcp.tool()
    async def get_project_topn_user_pr() -> str:
        """获取 PR 贡献个人开发者 Top N 排名。适用于 PPT 展示个人贡献者排行榜。"""
        result = await post("/server/project/topn/user/pr")
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无用户 PR 贡献数据"
        lines = ["开发者 PR 贡献 Top 排名："]
        for i, item in enumerate(data, 1):
            lines.append(f"  {i}. {item.get('name')}（{item.get('user')}）— {item.get('count')} 个 PR — 所属：{item.get('company')}")
        return "\n".join(lines)
