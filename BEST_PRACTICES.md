# OM-MCP 最佳实践

## 案例：查询社区月度活跃开发者人数

**场景**：查看某社区 2026 年每月当期活跃开发者人数。

### 完整查询流程

#### 第一步：确认社区名称

直接使用用户输入的社区名称（如 `mindsdk`）查询，若返回"暂无数据"，立即调用 `list_communities` 获取支持的社区列表，找到最接近的名称：

```
list_communities()
→ 支持社区：...mindseriessdk...
```

> **经验**：用户输入的社区名可能是缩写或别名，查询无数据时优先核查社区名称，而非重复查询。

#### 第二步：计算正确的毫秒时间戳

时间参数使用**毫秒级 Unix 时间戳**，常见年份参考值：

| 日期 | 毫秒时间戳 |
|------|-----------|
| 2026-01-01 00:00:00 | `1767196800000` |
| 2026-02-01 00:00:00 | `1769875200000` |
| 2026-03-01 00:00:00 | `1772294400000` |

#### 第三步：调用接口

```python
get_stats_contribute(
    community="mindseriessdk",
    interval="month",
    start=1772294400000,   # 2026-03-01
    end=1774972799000      # 2026-03-31（覆盖至 3 月末）
)
```

关键返回字段：

| 字段 | 含义 |
|------|------|
| `month_date` | 月份（如 `2026-01-01`） |
| `activate_user` | 当月活跃开发者数 |
| `merged_prs` | 当月合入 PR 数 |
| `issues` | 当月提交 Issue 数 |
| `merged_pr_user` | 当月合入 PR 的用户数 |

#### 查询结果示例

| 月份 | 活跃开发者数 |
|------|------------|
| 2026-01 | 113 |
| 2026-02 | 105 |
| 2026-03 | 115 |

---

## 通用原则

### 1. 社区名称处理
- 始终以 `list_communities` 返回的名称为准
- 查询无数据时，第一反应是核查社区名称

### 2. 时间戳计算
- 所有时间参数均为**毫秒级 UTC 时间戳**
- 查询某年全年：`start` = 该年 1 月 1 日，`end` = 下一年 1 月 1 日
- 查询上一个自然月（月度报告场景）：传入**上月末**的时间戳

### 3. 接口选择
- 月度趋势数据：`get_stats_contribute(interval="month")`
- 年度汇总：`get_stats_contribute(interval="year")`
- 日粒度：`get_stats_contribute(interval="day")`

---

## 案例：查询 SIG 组最近一次会议及参会人

**场景**：查看某 SIG 组最近预定的会议详情和参会人员名单。

### 完整查询流程

#### 第一步：查询最近一次会议

使用 `get_meeting_info`，指定 `sig_name`，按 `created_at` 倒序取第 1 条：

```python
get_meeting_info(
    community="openeuler",
    sig_name="sig-QA",
    sort="created_at",
    direction="desc",
    page_size=1
)
```

记录返回的 `meeting_id`（如 `3214`）。

#### 第二步：查询参会人

用上一步获取的 `meeting_id` 调用参会人接口：

```python
get_meeting_participants_info(
    community="openeuler",
    meeting_id="3214",
    page_size=50
)
```

> **注意**：参会人数据可能为"暂无数据"（如 TC 组），属正常现象，无需重试。

### 关键字段说明

**会议信息**：

| 字段 | 含义 |
|------|------|
| `meeting_id` | 会议唯一 ID，用于查参会人 |
| `sponsor` | 会议发起人 |
| `sig_name` | 所属 SIG 组 |
| `created_at` | 会议创建/预定日期 |
| `start` / `end` | 会议开始/结束时间 |
| `platform` | 会议平台（welink/zoom/tencent） |
| `join_url` | 会议入会链接 |

**参会人信息**：

| 字段 | 含义 |
|------|------|
| `user_name` | 参会人用户名 |

### 两步可并行

若已知 `meeting_id`，可同时发起两个查询；否则需串行（先获取 `meeting_id`，再查参会人）。

---

## 实际查询结果示例

### openeuler 社区最近一次会议

**会议信息**：

| 字段 | 内容 |
|------|------|
| 会议ID | 3174 |
| 主题 | openEuler TC双周例会 |
| SIG组 | TC |
| 发起人 | georgecao |
| 创建时间 | 2026-02-11 00:00:00 |
| 开始时间 | 10:00 |
| 结束时间 | 12:00 |
| 平台 | welink |
| 会议链接 | https://meeting.huaweicloud.com:36443/#/j/960493493 |
| Etherpad | https://etherpad.openeuler.org/p/TC-meetings |
| 邮件列表 | tc@openeuler.org;dev@openeuler.org |

**参与人信息**：暂无数据（API返回空列表）

---

### openeuler sig-QA 组最近一次会议

**会议信息**：

| 字段 | 内容 |
|------|------|
| 会议ID | 3214 |
| 主题 | QA SIG例会 |
| SIG组 | sig-QA |
| 发起人 | hfutsdd |
| 创建时间 | 2026-02-04 00:00:00 |
| 开始时间 | 14:15 |
| 结束时间 | 16:15 |
| 平台 | welink |
| 会议链接 | https://meeting.huaweicloud.com:36443/#/j/966359845 |
| Etherpad | https://etherpad.openeuler.org/p/sig-QA-meetings |
| 邮件列表 | qa@openeuler.org |

**参与人信息**（共15人）：

| 序号 | 用户名 |
|------|--------|
| 1 | chenyx130 |
| 2 | jiangxinyu |
| 3 | lemon |
| 4 | liangya lwx1276251 |
| 5 | Lijie l00498886 |
| 6 | shidongdong s00475742 |
| 7 | tangzhengliang t00886669 |
| 8 | wujie-iscas |
| 9 | Zhangziyang z00608440 |
| 10 | zhu_jinlong |
| 11 | zhuofeng z30027100 |
| 12 | 刘婧婧 |
| 13 | 张天宇 |
| 14 | 李永强 |
| 15 | 武碧洁 |
