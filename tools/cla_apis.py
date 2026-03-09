from mcp.server.fastmcp import FastMCP
from lib.http import post, extract_data


def register(mcp: FastMCP):

    @mcp.tool()
    async def get_cla_user_list(
        community: str = "openubmc",
        page: int = 1,
        page_size: int = 10,
        sign_type: str = "",
        name: str = "",
        start_time: str = "",
        end_time: str = "",
        order_by: str = "created_at",
        order_dir: str = "DESC",
    ) -> str:
        """获取 CLA（贡献者许可协议）签署用户分页列表，支持按社区、签署类型、姓名、时间筛选。
        适用于 PPT 展示 CLA 签署用户详情。

        Args:
            community: 社区名称，如 openubmc、openeuler、opengauss 等，默认 openubmc
            page: 页码，默认 1
            page_size: 每页数量，默认 10
            sign_type: 签署类型：企业 或 个人（可选）
            name: 按姓名模糊搜索（可选）
            start_time: 开始时间，格式 YYYY-MM-DD（可选）
            end_time: 结束时间，格式 YYYY-MM-DD（可选）
            order_by: 排序字段，可选 name/company/sign_type/created_at，默认 created_at
            order_dir: 排序方向 ASC/DESC，默认 DESC
        """
        body = {
            "community": community,
            "page": page,
            "pageSize": page_size,
            "order_by": order_by,
            "order_dir": order_dir,
        }
        if sign_type:
            body["sign_type"] = sign_type
        if name:
            body["name"] = name
        if start_time:
            body["start_time"] = start_time
        if end_time:
            body["end_time"] = end_time

        result = await post("/cla/page", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = result.get("data", {})
        user_list = data.get("list", [])
        total = data.get("total", len(user_list))
        lines = [f"CLA 签署用户列表 - 社区：{community}（第 {page} 页，共 {total} 人）："]
        for u in user_list:
            lines.append(
                f"  {u.get('name')}（{u.get('email')}）— {u.get('company')} — "
                f"{u.get('sign_type')} — 签署时间：{u.get('created_at', '')[:10]}"
            )
        return "\n".join(lines)

    @mcp.tool()
    async def get_cla_stats(
        community: str = "openubmc",
        start_time: str = "",
        end_time: str = "",
    ) -> str:
        """获取 CLA 签署统计：总签署数、企业签署数、个人签署数。
        适用于 PPT 展示社区 CLA 签署规模概览。

        Args:
            community: 社区名称，如 openubmc、openeuler 等，默认 openubmc
            start_time: 开始时间，格式 YYYY-MM-DD（可选）
            end_time: 结束时间，格式 YYYY-MM-DD（可选）
        """
        body = {"community": community}
        if start_time:
            body["start_time"] = start_time
        if end_time:
            body["end_time"] = end_time

        result = await post("/cla/stats", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = result.get("data", {})
        return (
            f"CLA 签署统计 - 社区：{community}：\n"
            f"  总签署数：{data.get('total', 'N/A')}\n"
            f"  企业签署：{data.get('enterprise', 'N/A')}\n"
            f"  个人签署：{data.get('individual', 'N/A')}"
        )

    @mcp.tool()
    async def get_cla_trend(
        community: str = "openubmc",
        interval: str = "month",
        start_time: str = "",
        end_time: str = "",
    ) -> str:
        """获取 CLA 签署趋势，按天/周/月统计企业和个人签署人数。
        适用于 PPT 展示 CLA 签署增长趋势折线图数据。

        Args:
            community: 社区名称，如 openubmc、openeuler 等，默认 openubmc
            interval: 时间粒度，可选 daily（天）/ week（周）/ month（月），默认 month
            start_time: 开始时间，格式 YYYY-MM-DD（可选）
            end_time: 结束时间，格式 YYYY-MM-DD（可选）
        """
        body = {"community": community, "interval": interval}
        if start_time:
            body["start_time"] = start_time
        if end_time:
            body["end_time"] = end_time

        result = await post("/cla/trend", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = result.get("data", [])
        if not data:
            return f"社区 {community} 暂无 CLA 趋势数据"
        lines = [f"CLA 签署趋势 - 社区：{community}，粒度：{interval}："]
        for item in data:
            lines.append(
                f"  {item.get('date')}：总计 {item.get('total')}，"
                f"企业 {item.get('enterprise')}，个人 {item.get('individual')}"
            )
        return "\n".join(lines)
