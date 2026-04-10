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
| 会议ID | 1247 |
| 主题 | Compiler SIG双周会议 |
| SIG组 | Compiler |
| 发起人 | chenzheng1030 |
| 创建时间 | 2026-03-31 00:00:00 |
| 开始时间 | 10:00 |
| 结束时间 | 11:30 |
| 平台 | ZOOM |
| 会议链接 | https://us06web.zoom.us/j/84869178160?pwd=vjYgGbJbJbbLbkHlUvKKsDrrL8xQTX.1 |
| Etherpad | https://etherpad.openeuler.org/p/Compiler-meetings |
| 议程 | 1. 近期工作进展同步 2.议题讨论环节（欢迎提前在 Etherpad会议纪要的 "二、议题列表"中提交您的议题） |

**参与人信息**（共16人）：

| 序号 | 用户名 |
|------|--------|
| 1 | 谢志恒 |
| 2 | Intel-胡林 |
| 3 | wuying |
| 4 | huawei-wangjiawei |
| 5 | 麒麟软件-金旭 |
| 6 | xiezhaokun |
| 7 | 王凯 |
| 8 | liweigang |
| 9 | ewang |
| 10 | 华为-李云飞 |
| 11 | douyiwang |
| 12 | 华为-李彦成 |
| 13 | beta |
| 14 | Jiacheng Zhou |
| 15 | 邓晓豫 |
| 16 | 陈正 |

---

## 案例：查询 SIG 组成员信息

### 关键字段说明

返回数据按角色分组，每个角色包含用户列表：

| 字段 | 含义 |
|------|------|
| `role` | 角色类型（committer/maintainer） |
| `users` | 该角色的用户列表 |
| `user_name` | 用户显示名称 |
| `user_login` | 用户登录名 |
| `email` | 用户邮箱 |
| `organization` | 所属组织（可选） |

### 实际查询结果示例

**openeuler 社区 Infrastructure SIG 组成员信息**：

**Committer（11人）**：

| 序号 | 用户名 | 登录名 | 邮箱 | 组织 |
|------|--------|--------|------|------|
| 1 | ctyunsystem | ctyunsystem | ctyuncommiter05@chinatelecom.cn | - |
| 2 | Se7en | liuqi469227928 | 469227928@qq.com | - |
| 3 | luweijun | lu-wei-army | wjunlu217@gmail.com | - |
| 4 | lichaoran | mywaaagh_admin | pkwarcraft@hotmail.com | - |
| 5 | TommyLike | TommyLike | tommylikehu@gmail.com | - |
| 6 | Tom | weixin_43493709 | tom_toworld@163.com | - |
| 7 | wenhao7 | wenhao7 | owen813@126.com | - |
| 8 | wukaishuns | wuzimo | wuksh@chinatelecom.cn | - |
| 9 | youyifeng | youyifeng | youyf2@chinatelecom.cn | - |
| 10 | Zheng Zhenyu | ZhengZhenyu | zheng.zhenyu@outlook.com | - |
| 11 | Yi Zhou | Zherphy | zhouyi198@h-partners.com | Huawei |
| 12 | zhaiwenjie | zwjsec | zhaiwenjiesec@163.com | - |

**Maintainer（7人）**：

| 序号 | 用户名 | 登录名 | 邮箱 | 组织 |
|------|--------|--------|------|------|
| 1 | Maquanyi | genedna | eli@patch.sh | - |
| 2 | George.Cao | georgecao | caozhi1214@qq.com | Huawei |
| 3 | imjoey | imjoey1 | majunjie@apache.org | - |
| 4 | TommyLike | TommyLike | tommylikehu@gmail.com | - |
| 5 | Yikun Jiang | yikunkero | yikunkero@gmail.com | - |
| 6 | zhongjun2 | zhongjun2 | 526521735@qq.com | - |
| 7 | Trainey | zhuchunyi | zhuchunyi@huawei.com | - |

> **注意**：部分用户可能同时属于多个角色（如 TommyLike 同时是 committer 和 maintainer），这是正常现象。

---

## 案例：查询社区所有 SIG 组名称

### 实际查询结果示例

**openUBMC 社区所有 SIG 组（12个）**：

| 序号 | SIG 组名称 |
|------|-----------|
| 1 | infrastructure |
| 2 | sig-ai |
| 3 | sig-bmc-core |
| 4 | sig-CICD |
| 5 | sig-component-drivers |
| 6 | sig-docs |
| 7 | sig-hardware |
| 8 | sig-interface |
| 9 | sig-QA |
| 10 | sig-release-management |
| 11 | sig-security |
| 12 | TC |

>  **注意**：TC（Technical Committee）通常作为技术委员会单独列出，不属于常规 SIG 组。

---

## 案例：查询社区所有组织类型

**场景**：查看某社区的组织架构，包括所有 SIG 组和组织列表。

### 完整查询流程

调用 `get_community_org_type` 接口：

```python
get_community_org_type(community="openeuler")
```

### 关键字段说明

| 字段 | 含义 |
|------|------|
| `sigs` | SIG 组列表（数组） |
| `orgs` | 组织列表（（数组） |

### 实际查询结果示例

**openEuler 社区组织类型**：

**SIG 组（109个）**：

ai, Application, A-Tune, Base-service, bigdata, Compiler, Computing, DB, Desktop, dev-utils, doc, ecopkg, G11N, GNOME, Infrastructure, iSulad, Kernel, Marketing, Networking, Others, oVirt, Packaging, Private, Programming-language, Runtime, security-committee, sig-AccLib, sig-Arm, sig-bio, sig-BMC, sig-CICD, sig-cinnamon, sig-CloudNative, sig-Compatibility-Infra, sig-compat-winapp, sig-compliance, sig-confidential-computing, sig-DDE, sig-desktop-apps, sig-DevStation, sig-distributed-middleware, sig-DPU, sig-EasyLife, sig-ebpf, sig-Edge, sig-embedded, sig-epkg, sig-epol, sig-FangTian, sig-Gatekeeper, sig-golang, sig-Ha, sig-haskell, sig-high-performance-network, sig-HPC, sig-Hygon, sig-IDE, sig-industrial-control, sig-Intel-Arch, sig-intelligence, sig-Java, sig-K8sDistro, sig-KDE, sig-KIRAN-DESKTOP, sig-Long, sig-LoongArch, sig-mate-desktop, sig-MCP-Tools-Ecosystem, sig-memsafety, sig-message-middleware, sig-Migration, sig-minzuchess, sig-nodejs, sig-OceanBase, sig-OpenDesign, sig-openstack, sig-ops, sig-OS-Builder, sig-OSCourse, sig-perl-modules, sig-porting-platform-winapp, sig-power-efficient, sig-python-modules, sig-QA, sig-QT, sig-recycle, sig-release-management, sig-RISC-V, sig-ROS, sig-ruby, sig-SBC, sig-sbom, sig-SDS, sig-security-facility, sig-Space, sig-sw-arch, sig-Talent-and-Service, sig-UB-ServiceCore, sig-UKUI, sig-UnifiedBus, sig-WayCa, sig-YuanRong, sig-Zephyr, Storage, System-tool, TC, user-committee, Virt, xfce

**组织（11个）**：

| 序号 | 组织名称 |
|------|---------|
| 1 | openEuler AI联合工作组 |
| 2 | openEuler 业务发展工作组 |
| 3 | openEuler 全球化工作组 |
| 4 | openEuler 品牌委员会 |
| 5 | openEuler 委员会 |
| 6 | openEuler 委员会顾问专家委员会 |
| 7 | openEuler 技术委员会 |
| 8 | openEuler 教育工作组 |
| 9 | openEuler 法务工作组 |
| 10 | openEuler 用户委员会 |
| 11 | openEuler 社区运营工作组 |

>  **注意**：此接口返回的是社区组织架构的顶层分类，可用于后续查询特定 SIG 组成员或组织成员详情。

---

## 案例：查询组织成员详情

**场景**：查看社区某个组织的成员详情，包括姓名、职位和所属机构。

### 完整查询流程

调用 `get_community_org_member` 接口：

```python
get_community_org_member(
    community="openeuler",
    org="openEuler 委员会"
)
```

### 关键字段说明

| 字段 | 含义 |
|------|------|
| `user_name` | 用户姓名 |
| `position` | 职位（主席/常务委员会委员/委员/执行总监/执行秘书等） |
| `organization` | 所属组织/机构 |
| `email` | 邮箱（可能为空） |

### 实际查询结果示例

**openEuler 委员会成员详情（共15人）**

**主席（1人）**：

| 职位 | 姓名 | 组织 |
|------|------|------|
| 主席 | 熊伟 | 华为技术有限公司 |

**常务委员会委员（5人）**：

| 职位 | 姓名 | 组织 |
|------|------|------|
| 常务委员会委员 | 韩乃平 | 麒麟软件有限公司 |
| 常务委员会委员 | 刘文清 | 湖南麒麟信安科技股份有限公司 |
| 常务委员会委员 | 屈晟 | 中国科学院软件研究所 |
| 常务委员会委员 | 张磊 | 统信软件技术有限公司 |

**委员（7人）**：

| 职位 | 姓名 | 组织 |
|------|------|------|
| 委员 | 高培 | 软通动力信息技术（集团）股份有限公司 |
| 委员 | 李培源 | 天翼云科技有限公司 |
| 委员 | 田俊 | 英特尔（中国）有限公司 |
| 委员 | 王皓 | 超聚变数字技术有限公司 |
| 委员 | 于力 | 南方电网数字电网科技有限（广东）公司 |
| 委员 | 于萍 | 江苏润和软件股份有限公司 |
| 委员 | 张胜举 | 中国移动云能力中心 |
| 委员 | 钟忻 | 联通数字科技有限公司 |

**执行人员（2人）**：

| 职位 | 姓名 | 组织 |
|------|------|------|
| 执行总监 | 胡正策 | 华为技术有限公司 |
| 执行秘书 | 刘彦飞 | 开放原子开源基金会 |

> **注意**：组织名称必须与 `get_community_org_type` 返回的 `orgs` 列表中的名称完全一致。






