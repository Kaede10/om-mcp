from datetime import datetime
from mcp.server.fastmcp import FastMCP
from lib.http import post, extract_data


def _date_to_ms(date_str: str) -> int:
    """将 YYYY-MM-DD 字符串转换为毫秒时间戳。"""
    dt = datetime.strptime(date_str.strip(), "%Y-%m-%d")
    return int(dt.timestamp() * 1000)


def _build_time_body(start_date: str, end_date: str) -> dict:
    """将日期字符串转为毫秒时间戳并放入 body。"""
    body = {}
    if start_date:
        body["start"] = _date_to_ms(start_date)
    if end_date:
        body["end"] = _date_to_ms(end_date)
    return body


def _fmt_page(data: dict, item_formatter, label: str) -> str:
    """通用分页结果格式化。"""
    if not isinstance(data, dict):
        return f"暂无{label}数据"
    items = data.get("list", [])
    total = data.get("total_count", len(items))
    total_page = data.get("total_page", 1)
    lines = [f"{label}（共 {total} 条，{total_page} 页）："]
    for item in items:
        lines.append(item_formatter(item))
    return "\n".join(lines)


def register(mcp: FastMCP):

    # ── 论坛 ──────────────────────────────────────────────────────────────

    @mcp.tool()
    async def get_forum_agg(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        namespace: str = "",
        repo_path: str = "",
        title: str = "",
        state: str = "",
        page_num: int = 1,
        page_size: int = 20,
        desc: str = "open_count",
    ) -> str:
        """获取论坛帖子汇总分页统计，支持按社区、仓库、状态筛选。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            namespace: 命名空间（可选）
            repo_path: 仓库路径（可选）
            title: 标题关键字（可选）
            state: 状态筛选（可选）
            page_num: 页码，默认 1
            page_size: 每页数量，默认 20
            desc: 降序排列字段，默认 open_count
        """
        body = _build_time_body(start_date, end_date)
        body.update({"pageNum": page_num, "pageSize": page_size})
        if community:
            body["community"] = community
        if namespace:
            body["namespace"] = namespace
        if repo_path:
            body["repo_path"] = repo_path
        if title:
            body["title"] = title
        if state:
            body["state"] = state
        if desc:
            body["desc"] = desc

        result = await post("/query/forum/agg", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无论坛汇总数据"

        def fmt(item):
            return (
                f"  [{item.get('repo_path', item.get('namespace', 'N/A'))}] "
                f"总数 {item.get('total_count', 0)}，开启 {item.get('open_count', 0)}，"
                f"关闭 {item.get('closed_count', 0)}"
            )

        return _fmt_page(data, fmt, "论坛汇总")

    @mcp.tool()
    async def get_forum_tag_agg(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        category_name: str = "",
        tag_name: str = "",
        group_dim: str = "",
        desc: str = "",
    ) -> str:
        """获取论坛标签维度汇总统计。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            category_name: 分类名称（可选）
            tag_name: 标签名称（可选）
            group_dim: 分组维度（可选）
            desc: 降序字段（可选）
        """
        body = _build_time_body(start_date, end_date)
        if community:
            body["community"] = community
        if category_name:
            body["category_name"] = category_name
        if tag_name:
            body["tag_name"] = tag_name
        if group_dim:
            body["group_dim"] = group_dim
        if desc:
            body["desc"] = desc

        result = await post("/query/forum/tag/agg", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无论坛标签数据"

        def fmt(item):
            return (
                f"  [{item.get('tag_name', item.get('category_name', 'N/A'))}] "
                f"总数 {item.get('total_count', 0)}"
            )

        return _fmt_page(data, fmt, "论坛标签汇总")

    @mcp.tool()
    async def get_forum_detail(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        title: str = "",
        desc: str = "created_at",
    ) -> str:
        """获取论坛帖子详情分页列表。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            title: 标题关键字（可选）
            desc: 降序字段，默认 created_at
        """
        body = _build_time_body(start_date, end_date)
        if community:
            body["community"] = community
        if title:
            body["title"] = title
        if desc:
            body["desc"] = desc

        result = await post("/query/forum/detail/page", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无论坛详情数据"

        def fmt(item):
            return (
                f"  [{item.get('created_at', 'N/A')[:10]}] "
                f"{item.get('title', 'N/A')} — "
                f"回复 {item.get('reply_count', 0)}，浏览 {item.get('view_count', 0)}"
            )

        return _fmt_page(data, fmt, "论坛帖子详情")

    # ── Issue ──────────────────────────────────────────────────────────────

    @mcp.tool()
    async def get_issues_agg_page(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        group_dim: str = "repo",
        namespace: str = "",
        repo_path: str = "",
        issue_type: str = "",
        source: str = "",
        private: str = "",
        desc: str = "open_count",
    ) -> str:
        """获取 Issue 汇总分页统计，支持按仓库/SIG/命名空间等维度分组。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            group_dim: 分组维度，如 repo/sig/namespace，默认 repo
            namespace: 命名空间筛选（可选）
            repo_path: 仓库路径筛选（可选）
            issue_type: Issue 类型筛选（可选）
            source: 来源平台（可选）
            private: 是否私仓，true/false（可选）
            desc: 降序字段，默认 open_count
        """
        body = _build_time_body(start_date, end_date)
        body["group_dim"] = group_dim
        if community:
            body["community"] = community
        if namespace:
            body["namespace"] = namespace
        if repo_path:
            body["repo_path"] = repo_path
        if issue_type:
            body["issue_type"] = issue_type
        if source:
            body["source"] = source
        if private:
            body["private"] = private
        if desc:
            body["desc"] = desc

        result = await post("/query/issues/agg", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无 Issue 汇总数据"

        def fmt(item):
            return (
                f"  [{item.get('repo_path', item.get('sig_name', item.get('namespace', 'N/A')))}] "
                f"总数 {item.get('total_count', 0)}，开启 {item.get('open_count', 0)}，"
                f"关闭率 {item.get('closed_ratio', 'N/A')}，"
                f"平均响应 {item.get('avg_first_reply_time', 'N/A')} 天"
            )

        return _fmt_page(data, fmt, f"Issue 汇总（按 {group_dim} 分组）")

    @mcp.tool()
    async def get_issues_agg_sig(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        sig_name: str = "",
        issue_type: str = "",
        source: str = "",
        desc: str = "open_count",
    ) -> str:
        """获取 Issue SIG 维度汇总统计。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            sig_name: SIG 名称筛选（可选）
            issue_type: Issue 类型（可选）
            source: 来源平台（可选）
            desc: 降序字段，默认 open_count
        """
        body = _build_time_body(start_date, end_date)
        if community:
            body["community"] = community
        if sig_name:
            body["sig_name"] = sig_name
        if issue_type:
            body["issue_type"] = issue_type
        if source:
            body["source"] = source
        if desc:
            body["desc"] = desc

        result = await post("/query/issues/agg/sig", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无 SIG Issue 数据"

        def fmt(item):
            return (
                f"  [{item.get('sig_name', 'N/A')}] "
                f"总数 {item.get('total_count', 0)}，开启 {item.get('open_count', 0)}，"
                f"关闭率 {item.get('closed_ratio', 'N/A')}"
            )

        return _fmt_page(data, fmt, "Issue SIG 汇总")

    @mcp.tool()
    async def get_issues_detail(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        namespace: str = "",
        repo_path: str = "",
        title: str = "",
        state: str = "",
        issue_type: str = "",
        priority: str = "",
        page_num: int = 1,
        page_size: int = 20,
    ) -> str:
        """获取 Issue 详情分页列表。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            namespace: 命名空间（可选）
            repo_path: 仓库路径（可选）
            title: 标题关键字（可选）
            state: 状态（open/closed，可选）
            issue_type: Issue 类型（可选）
            priority: 优先级（可选）
            page_num: 页码，默认 1
            page_size: 每页数量，默认 20
        """
        body = _build_time_body(start_date, end_date)
        body.update({"pageNum": page_num, "pageSize": page_size})
        if community:
            body["community"] = community
        if namespace:
            body["namespace"] = namespace
        if repo_path:
            body["repo_path"] = repo_path
        if title:
            body["title"] = title
        if state:
            body["state"] = state
        if issue_type:
            body["issue_type"] = issue_type
        if priority:
            body["priority"] = priority

        result = await post("/query/issues/detail", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无 Issue 详情数据"

        def fmt(item):
            return (
                f"  #{item.get('issue_number', 'N/A')} [{item.get('state', 'N/A')}] "
                f"{item.get('title', 'N/A')[:60]} "
                f"— {item.get('repo_path', 'N/A')} "
                f"— {item.get('created_at', 'N/A')}"
            )

        return _fmt_page(data, fmt, "Issue 详情")

    @mcp.tool()
    async def get_issue_ref_pr(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        namespace: str = "",
        repo_path: str = "",
        sig_group: str = "",
        pr_state: str = "",
        issue_state: str = "",
        pr_number: str = "",
        issue_number: str = "",
    ) -> str:
        """获取 Issue 关联 PR 信息，查看 Issue 和 PR 的关联关系。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            namespace: 命名空间（可选）
            repo_path: 仓库路径（可选）
            sig_group: SIG 组（可选）
            pr_state: PR 状态（open/merged/closed，可选）
            issue_state: Issue 状态（open/closed，可选）
            pr_number: PR 编号（可选）
            issue_number: Issue 编号（可选）
        """
        body = _build_time_body(start_date, end_date)
        if community:
            body["community"] = community
        if namespace:
            body["namespace"] = namespace
        if repo_path:
            body["repo_path"] = repo_path
        if sig_group:
            body["sig_group"] = sig_group
        if pr_state:
            body["pr_state"] = pr_state
        if issue_state:
            body["issue_state"] = issue_state
        if pr_number:
            body["pr_number"] = pr_number
        if issue_number:
            body["issue_number"] = issue_number

        result = await post("/query/issue/ref/pr", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无 Issue 关联 PR 数据"

        def fmt(item):
            return (
                f"  Issue #{item.get('issue_number', 'N/A')} [{item.get('issue_state', 'N/A')}] "
                f"← PR #{item.get('pr_number', 'N/A')} [{item.get('pr_state', 'N/A')}] "
                f"— {item.get('repo_path', 'N/A')}"
            )

        return _fmt_page(data, fmt, "Issue 关联 PR")

    # ── PR ────────────────────────────────────────────────────────────────

    @mcp.tool()
    async def get_prs_agg_page(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        group_dim: str = "repo",
        namespace: str = "",
        repo: str = "",
        pr_type: str = "",
        private: str = "",
        desc: str = "open_count",
    ) -> str:
        """获取 PR 汇总分页统计，支持按仓库/SIG/命名空间等维度分组。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            group_dim: 分组维度，如 repo/sig/namespace，默认 repo
            namespace: 命名空间筛选（可选）
            repo: 仓库名称（可选）
            pr_type: PR 类型（可选）
            private: 是否私仓，true/false（可选）
            desc: 降序字段，默认 open_count
        """
        body = _build_time_body(start_date, end_date)
        body["group_dim"] = group_dim
        if community:
            body["community"] = community
        if namespace:
            body["namespace"] = namespace
        if repo:
            body["repo"] = repo
        if pr_type:
            body["pr_type"] = pr_type
        if private:
            body["private"] = private
        if desc:
            body["desc"] = desc

        result = await post("/query/prs/agg", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无 PR 汇总数据"

        def fmt(item):
            return (
                f"  [{item.get('repo_path', item.get('sig_name', item.get('namespace', 'N/A')))}] "
                f"总数 {item.get('total_count', 0)}，开启 {item.get('open_count', 0)}，"
                f"合并率 {item.get('merged_ratio', 'N/A')}，"
                f"平均响应 {item.get('avg_first_reply_time', 'N/A')} 天"
            )

        return _fmt_page(data, fmt, f"PR 汇总（按 {group_dim} 分组）")

    @mcp.tool()
    async def get_prs_detail(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        namespace: str = "",
        repo_path: str = "",
        title: str = "",
        state: str = "",
        page_num: int = 1,
        page_size: int = 20,
    ) -> str:
        """获取 PR 详情分页列表。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            namespace: 命名空间（可选）
            repo_path: 仓库路径（可选）
            title: 标题关键字（可选）
            state: 状态（open/merged/closed，可选）
            page_num: 页码，默认 1
            page_size: 每页数量，默认 20
        """
        body = _build_time_body(start_date, end_date)
        body.update({"pageNum": page_num, "pageSize": page_size})
        if community:
            body["community"] = community
        if namespace:
            body["namespace"] = namespace
        if repo_path:
            body["repo_path"] = repo_path
        if title:
            body["title"] = title
        if state:
            body["state"] = state

        result = await post("/query/prs/detail", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无 PR 详情数据"

        def fmt(item):
            return (
                f"  #{item.get('pr_number', 'N/A')} [{item.get('state', 'N/A')}] "
                f"{item.get('title', 'N/A')[:60]} "
                f"— {item.get('repo_path', 'N/A')} "
                f"— {item.get('created_at', 'N/A')}"
            )

        return _fmt_page(data, fmt, "PR 详情")

    # ── SIG ───────────────────────────────────────────────────────────────

    @mcp.tool()
    async def get_sig_leverage_ratio(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        source: str = "",
        sig_list: str = "",
    ) -> str:
        """获取 SIG 撬动比（外部贡献占比）统计。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            source: 来源平台（可选）
            sig_list: 逗号分隔的 SIG 名称列表（可选），如 "kernel,storage"
        """
        body = _build_time_body(start_date, end_date)
        if community:
            body["community"] = community
        if source:
            body["source"] = source
        if sig_list:
            body["sigList"] = [s.strip() for s in sig_list.split(",") if s.strip()]

        result = await post("/query/sig/leverage-ratio", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无 SIG 撬动比数据"

        total_perc = data.get("total_addcode_perc", "N/A") if isinstance(data, dict) else "N/A"
        items = data.get("list", []) if isinstance(data, dict) else (data if isinstance(data, list) else [])
        lines = [f"SIG 撬动比统计（总外部代码占比：{total_perc}）："]
        for item in items:
            lines.append(
                f"  [{item.get('sig_name', 'N/A')}] "
                f"外部占比 {item.get('addcode_perc', 'N/A')}，"
                f"外部代码行 {item.get('addcode_external', 'N/A')}，"
                f"总代码行 {item.get('addcode_total', 'N/A')}"
            )
        return "\n".join(lines)

    # ── 开发者 ─────────────────────────────────────────────────────────────

    @mcp.tool()
    async def get_users_page(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        page_num: int = 1,
        page_size: int = 20,
    ) -> str:
        """获取开发者汇总分页列表。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            page_num: 页码，默认 1
            page_size: 每页数量，默认 20
        """
        body = _build_time_body(start_date, end_date)
        body.update({"pageNum": page_num, "pageSize": page_size})
        if community:
            body["community"] = community

        result = await post("/query/users/page", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无开发者数据"

        def fmt(item):
            return (
                f"  {item.get('name', item.get('user_login', 'N/A'))} "
                f"({item.get('company', 'N/A')}) — "
                f"PR {item.get('pr_count', 0)}，Issue {item.get('issue_count', 0)}，"
                f"评论 {item.get('comment_count', 0)}"
            )

        return _fmt_page(data, fmt, "开发者列表")

    @mcp.tool()
    async def get_users_trend(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        interval: str = "month",
        metric: str = "",
        event_list: str = "",
        org_list: str = "",
    ) -> str:
        """获取开发者趋势统计（按时间段统计开发者数量变化）。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            interval: 时间粒度，day/week/month，默认 month
            metric: 统计维度（可选）
            event_list: 逗号分隔的事件类型列表（可选），如 "pr,issue"
            org_list: 逗号分隔的组织列表（可选）
        """
        body = _build_time_body(start_date, end_date)
        body["interval"] = interval
        if community:
            body["community"] = community
        if metric:
            body["metric"] = metric
        if event_list:
            body["eventList"] = [e.strip() for e in event_list.split(",") if e.strip()]
        if org_list:
            body["orgList"] = [o.strip() for o in org_list.split(",") if o.strip()]

        result = await post("/query/users", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无开发者趋势数据"

        if isinstance(data, list):
            lines = [f"开发者趋势统计（粒度：{interval}，共 {len(data)} 个时间点）："]
            for item in data:
                lines.append(
                    f"  {item.get('date', item.get('time_bucket', 'N/A'))}: "
                    f"活跃 {item.get('active_count', item.get('count', 'N/A'))}"
                )
            return "\n".join(lines)

        return f"开发者趋势数据：{data}"

    # ── 服务 ───────────────────────────────────────────────────────────────

    @mcp.tool()
    async def get_source_total(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        source: str = "",
        group_dim: str = "",
        namespace: str = "",
        private: str = "",
        desc: str = "open_count",
    ) -> str:
        """获取论坛/邮件/会议等服务平台汇总数据。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            source: 来源平台，如 forum/email/meeting（可选）
            group_dim: 分组维度（可选）
            namespace: 命名空间（可选）
            private: 是否私仓，true/false（可选）
            desc: 降序字段，默认 open_count
        """
        body = _build_time_body(start_date, end_date)
        if community:
            body["community"] = community
        if source:
            body["source"] = source
        if group_dim:
            body["group_dim"] = group_dim
        if namespace:
            body["namespace"] = namespace
        if private:
            body["private"] = private
        if desc:
            body["desc"] = desc

        result = await post("/query/source/total", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无服务汇总数据"

        if isinstance(data, list):
            lines = [f"服务汇总（来源：{source or '全部'}，共 {len(data)} 条）："]
            for item in data:
                lines.append(
                    f"  [{item.get('repo_path', item.get('list_id', item.get('sig_name', 'N/A')))}] "
                    f"总数 {item.get('total_count', item.get('email_count', 0))}"
                )
            return "\n".join(lines)

        def fmt(item):
            return (
                f"  [{item.get('source', 'N/A')}] "
                f"总数 {item.get('total_count', 0)}"
            )

        return _fmt_page(data, fmt, "服务汇总")

    @mcp.tool()
    async def get_source_trend(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        source: str = "",
        interval: str = "month",
        metrics: str = "",
    ) -> str:
        """获取论坛/邮件/会议等服务平台趋势数据。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            source: 来源平台，如 forum/email/meeting（可选）
            interval: 时间粒度，day/week/month，默认 month
            metrics: 指标类型（可选）
        """
        body = {"interval": interval}
        if start_date:
            body["startDate"] = _date_to_ms(start_date)
        if end_date:
            body["endDate"] = _date_to_ms(end_date)
        if community:
            body["community"] = community
        if source:
            body["source"] = source
        if metrics:
            body["metrics"] = metrics

        result = await post("/query/source/trend", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无服务趋势数据"

        if isinstance(data, list):
            lines = [f"服务趋势（来源：{source or '全部'}，粒度：{interval}，共 {len(data)} 个时间点）："]
            for item in data:
                date_str = item.get("date", item.get("time_bucket", "N/A"))
                count = item.get("total_count", item.get("count", item.get("email_count", "N/A")))
                lines.append(f"  {date_str}: {count}")
            return "\n".join(lines)

        return f"服务趋势数据：{data}"

    # ── 注册用户 ───────────────────────────────────────────────────────────

    @mcp.tool()
    async def get_regist_user_detail(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        source: str = "",
        company: str = "",
        internal: str = "",
        page_num: int = 1,
        page_size: int = 20,
    ) -> str:
        """获取注册用户详情分页列表。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            source: 来源平台（可选）
            company: 企业名称筛选（可选）
            internal: 内外部标识（可选）
            page_num: 页码，默认 1
            page_size: 每页数量，默认 20
        """
        body = _build_time_body(start_date, end_date)
        body.update({"pageNum": page_num, "pageSize": page_size})
        if community:
            body["community"] = community
        if source:
            body["source"] = source
        if company:
            body["company"] = company
        if internal:
            body["internal"] = internal

        result = await post("/query/regist/user/detail", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无注册用户数据"

        def fmt(item):
            return (
                f"  {item.get('name', item.get('user_login', 'N/A'))} "
                f"({item.get('company', 'N/A')}, {item.get('internal', 'N/A')}) — "
                f"注册于 {item.get('created_at', 'N/A')}"
            )

        return _fmt_page(data, fmt, "注册用户详情")

    # ── 筛选条件 ───────────────────────────────────────────────────────────

    @mcp.tool()
    async def get_filter_options(community: str = "", tab: str = "") -> str:
        """获取社区数据筛选条件（如 SIG 列表、仓库列表、标签等）。

        Args:
            community: 社区名称（可选）
            tab: 标签页标识，如 issue/pr/repo 等（可选）
        """
        body = {}
        if community:
            body["community"] = community
        if tab:
            body["tab"] = tab

        result = await post("/query/filter", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无筛选条件数据"

        if isinstance(data, dict):
            lines = [f"筛选条件（社区：{community or '全部'}，标签页：{tab or '全部'}）："]
            for key, val in data.items():
                if isinstance(val, list):
                    lines.append(f"  {key}：{', '.join(str(v) for v in val[:10])}"
                                 + ("..." if len(val) > 10 else ""))
                else:
                    lines.append(f"  {key}：{val}")
            return "\n".join(lines)

        return f"筛选条件：{data}"

    # ── 组织 ───────────────────────────────────────────────────────────────

    @mcp.tool()
    async def get_company_detail(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        source: str = "",
        internal: str = "",
        page_num: int = 1,
        page_size: int = 20,
    ) -> str:
        """获取参与社区的组织/企业详情分页列表。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            source: 来源平台（可选）
            internal: 内外部标识（可选）
            page_num: 页码，默认 1
            page_size: 每页数量，默认 20
        """
        body = _build_time_body(start_date, end_date)
        body.update({"pageNum": page_num, "pageSize": page_size})
        if community:
            body["community"] = community
        if source:
            body["source"] = source
        if internal:
            body["internal"] = internal

        result = await post("/query/company/detail", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无组织详情数据"

        def fmt(item):
            return (
                f"  {item.get('company', 'N/A')} ({item.get('internal', 'N/A')}) — "
                f"PR {item.get('pr_count', 0)}，Issue {item.get('issue_count', 0)}，"
                f"开发者 {item.get('user_count', 0)}"
            )

        return _fmt_page(data, fmt, "组织详情")

    @mcp.tool()
    async def get_company_trend(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        source: str = "",
        company: str = "",
        internal: str = "",
        interval: str = "month",
    ) -> str:
        """获取组织/企业参与趋势数据。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            source: 来源平台（可选）
            company: 企业名称（可选）
            internal: 内外部标识（可选）
            interval: 时间粒度，day/week/month，默认 month
        """
        body = _build_time_body(start_date, end_date)
        body["interval"] = interval
        if community:
            body["community"] = community
        if source:
            body["source"] = source
        if company:
            body["company"] = company
        if internal:
            body["internal"] = internal

        result = await post("/query/trend/company", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无组织趋势数据"

        if isinstance(data, list):
            lines = [f"组织趋势（粒度：{interval}，共 {len(data)} 个时间点）："]
            for item in data:
                lines.append(
                    f"  {item.get('date', 'N/A')}: "
                    f"企业数 {item.get('company_count', item.get('count', 'N/A'))}"
                )
            return "\n".join(lines)

        return f"组织趋势数据：{data}"

    # ── 贡献 ───────────────────────────────────────────────────────────────

    @mcp.tool()
    async def get_contributes_topn(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        event: str = "pr",
        metric: str = "company_type",
        topn: int = 10,
        private: str = "false",
        org_list: str = "",
    ) -> str:
        """获取贡献 TopN 汇总排名，支持按组织/仓库/SIG/开发者维度统计。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            event: 贡献类型，pr/issue/comment/addcode，默认 pr
            metric: 统计维度，company_type/company/sig/repo/user，默认 company_type
            topn: TopN 数量，默认 10
            private: 是否包含私仓，true/false，默认 false
            org_list: 逗号分隔的命名空间/组织列表（可选）
        """
        body = _build_time_body(start_date, end_date)
        body.update({
            "event": event,
            "metric": metric,
            "topn": topn,
            "private": private,
        })
        if community:
            body["community"] = community
        if org_list:
            body["orgList"] = [o.strip() for o in org_list.split(",") if o.strip()]

        result = await post("/query/contributes/topn/total", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无贡献 TopN 数据"

        items = data if isinstance(data, list) else data.get("list", [])
        # 确定主要计数字段名
        count_field = f"{event}_total" if event in ("pr", "issue", "comment", "addcode") else "pr_total"
        # 确定维度字段名
        dim_field_map = {
            "company_type": "company_type",
            "company": "company",
            "sig": "sig_name",
            "repo": "repo_path",
            "user": "user_level",
        }
        dim_field = dim_field_map.get(metric, metric)

        lines = [f"贡献 Top{topn}（维度：{metric}，类型：{event}）："]
        for i, item in enumerate(items, 1):
            rank = item.get("row_num", i)
            dim_val = item.get(dim_field, "N/A")
            count = item.get(count_field, item.get("pr_total", 0))
            total = item.get("total_count", "N/A")
            lines.append(f"  {rank}. {dim_val} — {count}（全量：{total}）")

        return "\n".join(lines)

    @mcp.tool()
    async def get_contributes_topn_item(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        event: str = "pr",
        metric: str = "repo",
        metric_val: str = "",
        interval: str = "month",
        source: str = "",
        private: str = "false",
    ) -> str:
        """获取贡献 TopN 明细（某维度值的时间序列数据）。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            event: 贡献类型，pr/issue/comment/addcode，默认 pr
            metric: 统计维度，repo/sig/company，默认 repo
            metric_val: 维度值，如仓库名或 SIG 名（可选）
            interval: 时间粒度，day/week/month，默认 month
            source: 来源平台（可选）
            private: 是否包含私仓，true/false，默认 false
        """
        body = _build_time_body(start_date, end_date)
        body.update({
            "event": event,
            "metric": metric,
            "interval": interval,
            "private": private,
        })
        if community:
            body["community"] = community
        if metric_val:
            body["metricVal"] = metric_val
        if source:
            body["source"] = source

        result = await post("/query/contributes/topn/item", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无贡献明细数据"

        items = data if isinstance(data, list) else []
        lines = [f"贡献明细（维度：{metric}={metric_val or '全部'}，类型：{event}，粒度：{interval}）："]
        for item in items:
            date_str = item.get("date", item.get("time_bucket", "N/A"))
            count = item.get(f"{event}_total", item.get("count", "N/A"))
            lines.append(f"  {date_str}: {count}")

        return "\n".join(lines)

    @mcp.tool()
    async def get_contributes_page(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        metric: str = "",
        source: str = "",
        private: str = "",
        internal: str = "",
        org_list: str = "",
        page_num: int = 1,
        page_size: int = 20,
        desc: str = "pr_total",
    ) -> str:
        """获取贡献汇总分页列表（按组织/仓库等聚合）。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            metric: 统计维度（可选）
            source: 来源平台（可选）
            private: 是否私仓（可选）
            internal: 内外部标识（可选）
            org_list: 逗号分隔的组织列表（可选）
            page_num: 页码，默认 1
            page_size: 每页数量，默认 20
            desc: 降序字段，默认 pr_total
        """
        body = _build_time_body(start_date, end_date)
        body.update({"pageNum": page_num, "pageSize": page_size})
        if community:
            body["community"] = community
        if metric:
            body["metric"] = metric
        if source:
            body["source"] = source
        if private:
            body["private"] = private
        if internal:
            body["internalList"] = [internal]
        if org_list:
            body["orgList"] = [o.strip() for o in org_list.split(",") if o.strip()]
        if desc:
            body["desc"] = desc

        result = await post("/query/contributes/page", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无贡献分页数据"

        def fmt(item):
            return (
                f"  {item.get('company', item.get('repo_path', item.get('sig_name', 'N/A')))} — "
                f"PR {item.get('pr_total', 0)}，Issue {item.get('issue_total', 0)}，"
                f"评论 {item.get('comment_total', 0)}，"
                f"代码行 {item.get('addcode_total', 0)}"
            )

        return _fmt_page(data, fmt, "贡献汇总")

    @mcp.tool()
    async def get_contributes_trend(
        community: str = "",
        start_date: str = "",
        end_date: str = "",
        interval: str = "month",
        metric: str = "",
        event_list: str = "pr",
        org_list: str = "",
    ) -> str:
        """获取贡献趋势统计（按时间段统计各类贡献数量）。

        Args:
            community: 社区名称（可选）
            start_date: 开始日期，格式 YYYY-MM-DD（可选）
            end_date: 结束日期，格式 YYYY-MM-DD（可选）
            interval: 时间粒度，day/week/month，默认 month
            metric: 统计维度（可选）
            event_list: 逗号分隔的贡献类型列表，如 "pr,issue,comment"，默认 pr
            org_list: 逗号分隔的组织列表（可选）
        """
        body = _build_time_body(start_date, end_date)
        body["interval"] = interval
        if community:
            body["community"] = community
        if metric:
            body["metric"] = metric
        if event_list:
            body["eventList"] = [e.strip() for e in event_list.split(",") if e.strip()]
        if org_list:
            body["orgList"] = [o.strip() for o in org_list.split(",") if o.strip()]

        result = await post("/query/contributes", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无贡献趋势数据"

        if isinstance(data, list):
            lines = [f"贡献趋势（粒度：{interval}，类型：{event_list}，共 {len(data)} 个时间点）："]
            for item in data:
                date_str = item.get("date", item.get("time_bucket", "N/A"))
                pr = item.get("pr_total", item.get("pr_count", ""))
                issue = item.get("issue_total", item.get("issue_count", ""))
                comment = item.get("comment_total", item.get("comment_count", ""))
                parts = []
                if pr != "":
                    parts.append(f"PR {pr}")
                if issue != "":
                    parts.append(f"Issue {issue}")
                if comment != "":
                    parts.append(f"评论 {comment}")
                lines.append(f"  {date_str}: {', '.join(parts) or str(item)}")
            return "\n".join(lines)

        return f"贡献趋势数据：{data}"

    # ── 账号趋势 ───────────────────────────────────────────────────────────

    @mcp.tool()
    async def get_account_trend(community: str = "", tab: str = "") -> str:
        """获取社区账号注册趋势数据。

        Args:
            community: 社区名称（可选）
            tab: 标签页标识（可选）
        """
        body = {}
        if community:
            body["community"] = community
        if tab:
            body["tab"] = tab

        result = await post("/query/trend/account", body)
        if result.get("code") != 1:
            return f"API 错误：{result.get('message', '未知错误')}"
        data = extract_data(result)
        if not data:
            return "暂无账号趋势数据"

        if isinstance(data, list):
            lines = [f"账号趋势（共 {len(data)} 个时间点）："]
            for item in data:
                lines.append(
                    f"  {item.get('date', 'N/A')}: "
                    f"新增 {item.get('new_count', item.get('count', 'N/A'))}，"
                    f"累计 {item.get('total_count', 'N/A')}"
                )
            return "\n".join(lines)

        if isinstance(data, dict):
            lines = ["账号趋势："]
            for k, v in data.items():
                lines.append(f"  {k}: {v}")
            return "\n".join(lines)

        return f"账号趋势数据：{data}"
