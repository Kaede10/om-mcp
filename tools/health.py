from mcp.server.fastmcp import FastMCP
from lib.http import get

# 社区名称映射（统一转小写匹配）
COMMUNITY_MAP = {
    "openeuler":           "openEuler",
    "opengauss":           "openGauss",
    "openubmc":            "openUBMC",
    "mindspore":           "MindSpore",
    "openfuyao":           "openFuyao",
    "vllm":                "vllm",
    "cann":                "CannOpen",   # CANN 对应 CannOpen
    "cannopen":            "CannOpen",
    "mindie":              "MindIE",
    "mindstudio":          "MindStudio",
    "mindseriessdk":       "MindSeriesSDK",
    "mindcluster":         "MindCluster",
    "pta":                 "PTA",
    "unifiedbus":          "UnifiedBus",
    "sgl":                 "sgl",
    "pytorch":             "pytorch",
    "triton":              "triton",
    "mindspeed":           "MindSpeed",
    "tilelang":            "TileLang",
    "verl":                "VeRL",
    "ascendnpuir":         "ascendnpuir",
    "boostkit":            "boostkit",
    "opensource":          "opensource",
}

# 指标说明（用于格式化输出）
METRIC_LABELS = {
    "nss":                    "社区影响力(NSS)",
    "download":               "下载量",
    "issue_close":            "Issue关闭率",
    "certification":          "认证",
    "first_response":         "首次响应",
    "leverage_ratio":         "杠杆率",
    "tech_influence":         "技术影响力",
    "version_release":        "版本发布",
    "elephant_coefficient":   "大象系数",
    "effective_maintenance":  "有效维护",
    "contribution_diversity": "贡献多样性",
    "contributor_interaction":"贡献者互动",
}


def register(mcp: FastMCP):

    @mcp.tool()
    async def get_community_health(community: str) -> str:
        """查询指定社区的健康度指标数据，返回综合评分及各子指标分数。

        Args:
            community: 社区名称，如 openEuler、MindSpore、CANN、openGauss 等，大小写不敏感。
        """
        key = community.strip().lower()
        api_community = COMMUNITY_MAP.get(key)
        if not api_community:
            available = ", ".join(sorted(COMMUNITY_MAP.keys()))
            return f"未找到社区 '{community}'，可用社区（小写）：{available}"

        result = await get(f"/server/health/{api_community}/metric", params={"mode": "general"})

        if result.get("code") != 1:
            return f"API 返回错误：{result.get('message', '未知错误')}"

        data = result.get("data")
        if not data:
            return f"社区 {api_community} 暂无健康度数据"
        avg = data.get("avg_score", "N/A")

        lines = [
            f"社区：{api_community}",
            f"数据日期：{data.get('created_at', 'N/A')}",
            f"综合健康度评分：{avg} / 5.0",
            "",
            "各指标评分（1-5分）及原始值：",
        ]

        for key, label in METRIC_LABELS.items():
            score = data.get(key, "-")
            raw = data.get(f"{key}_value", "-")
            lines.append(f"  - {label}：{score} 分（原始值：{raw}）")

        return "\n".join(lines)
