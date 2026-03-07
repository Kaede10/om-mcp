from mcp.server.fastmcp import FastMCP
from lib.http import post, extract_data


def register(mcp: FastMCP):

    @mcp.tool()
    async def get_ci_metrics(community: str = "", start_time: str = "", end_time: str = "") -> str:
        """获取项目 CI（持续集成）指标：总运行次数、成功/失败/待处理数、成功率、平均时长及趋势。
        适用于 PPT 展示社区 CI 质量保障数据。

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

        result = await post("/project/ci/metric", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无 CI 指标数据"

        trend = data.get("trend", [])
        trend_lines = []
        for t in trend:
            trend_lines.append(f"      {t.get('date')}：成功率 {t.get('success_rate')*100:.0f}%，总次数 {t.get('total')}")

        return (
            f"CI 指标统计：\n"
            f"  总运行次数：{data.get('total_runs', 'N/A')}\n"
            f"  成功：{data.get('success_count', 'N/A')}\n"
            f"  失败：{data.get('failed_count', 'N/A')}\n"
            f"  待处理：{data.get('pending_count', 'N/A')}\n"
            f"  整体成功率：{data.get('success_rate', 0)*100:.0f}%\n"
            f"  平均运行时长：{data.get('avg_duration', 'N/A')} 分钟\n"
            f"  近期趋势：\n" + "\n".join(trend_lines)
        )
