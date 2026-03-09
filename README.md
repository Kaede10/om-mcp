# om-metrics MCP Server

<div align="center">

**开源社区数据查询 MCP 服务器**

为 Claude Desktop 提供开源社区数据查询能力的 Model Context Protocol 服务器

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/)

</div>

---

## 目录

**👤 我是用户**
- [项目简介](#-项目简介)
- [核心功能](#-核心功能)
- [快速开始](#-快速开始)
- [使用方式](#-使用方式)

**🛠️ 我是开发者**
- [开发指南](#-开发指南)
- [项目结构](#项目结构)
- [添加新工具](#添加新工具)
- [测试](#测试)
- [故障排查](#-故障排查)

---

## 🦎 项目简介

om-metrics MCP Server 是一款面向**开源社区运营团队**和**数据分析人员**的 MCP 工具，通过 Claude Desktop 提供自然语言查询开源社区数据的能力。

### 适用人群

| 角色 | 使用场景 |
|------|---------|
| **社区运营** | 查询社区健康度、PR/Issue 统计、贡献者排行 |
| **数据分析师** | 获取社区趋势数据、生成运营报告、制作 PPT |
| **开发者** | 查询 CI/CD 指标、仓库活跃度、技术栈分布 |
| **管理者** | 跨社区对比分析、企业贡献统计、CLA 签署情况 |

### 支持的社区

支持 **23 个开源社区**，包括：
- **华为开源社区**：openEuler、openGauss、openUBMC、CANN
- **AI 框架**：MindSpore、MindIE、MindStudio、MindSpeed、MindSeriesSDK、MindCluster
- **推理加速**：vllm、sgl、VeRL、pytorch、triton
- **其他项目**：openFuyao、PTA、UnifiedBus、CannOpen、TileLang、ascendnpuir、boostkit、opensource

---

## ✨ 核心功能

### 📊 社区健康度分析
- **综合评分**：查询社区健康度综合评分（1-5 分）
- **子指标分析**：社区影响力、下载量、Issue 关闭率、PR 合并率等
- **趋势追踪**：按月/周/天统计社区活跃度变化

### 🔍 PR/Issue 统计
- **聚合统计**：总数、开启数、关闭数、合并数、响应时长、关闭率
- **按 SIG 分组**：各兴趣组的 PR/Issue 分布和处理效率
- **时间维度**：支持按天/周/月查询趋势数据

### 👥 贡献者分析
- **企业排行**：Top N 企业贡献数量和占比
- **个人排行**：Top N 个人开发者贡献统计
- **活跃用户**：仓库活跃用户列表（PR/Issue/评论数）
- **组织统计**：参与社区的企业/组织数量

### 📝 CLA 签署查询
- **签署统计**：总签署数、企业签署数、个人签署数
- **签署趋势**：按月/周/天统计签署增长趋势
- **用户列表**：分页查询签署用户详情（支持按类型、姓名、时间筛选和排序）

### 🚀 CI/CD 指标
- **运行统计**：总运行次数、成功/失败/待处理数、成功率
- **性能分析**：平均运行时长、趋势变化

### 📦 项目仓库
- **仓库列表**：最近更新的 50 个仓库
- **热点仓库**：最近更新的前 10 个热点仓库
- **活跃统计**：总仓库数、活跃数、非活跃数

---

---

## 🚀 快速开始

> 适合新用户快速安装和配置。开发者详细指南见[开发指南](#-开发指南)。

### 前置要求

- Python 3.8+
- Claude Desktop 或 Claude Code CLI
- 网络连接（需访问 `https://datastat.osinfra.cn/server/`）

### 安装步骤

**1. 克隆项目**

```bash
git clone https://github.com/zhongjun2/om-mcp.git
cd om-mcp
```

**2. 安装依赖**

```bash
pip install -e .
```

**3. 验证安装**

```bash
python3 -c "from server import mcp; print('安装成功')"
```

**4. 配置 Claude Desktop**

在 Claude Desktop 中，项目根目录已包含 `.mcp.json` 配置文件，会自动识别。

或手动配置全局 MCP 服务器（编辑 `~/.config/Claude/claude_desktop_config.json`）：

```json
{
  "mcpServers": {
    "om-metrics": {
      "command": "python3",
      "args": ["-m", "om-mcp"],
      "cwd": "/完整路径/om-mcp"
    }
  }
}
```

**5. 验证连接**

在 Claude Desktop 中运行：

```
/mcp
```

应该看到：
```
❯ om-metrics · ✔ connected
```

---

## 💡 使用方式

在 Claude Desktop 或 Claude Code 中直接用自然语言提问，MCP 工具会自动调用。

### 基础查询示例

```
查询 openEuler 社区的健康度评分
openEuler 社区 2025 年的 PR 总数
CANN 社区有多少个参与的企业？
查询 MindSpore 社区最近的热点仓库
```

### 趋势分析示例

```
openEuler 2025 年每月的 PR 合并趋势
MindSpore 社区 2025 年 1-3 月的 Issue 关闭率
openUBMC 社区 2025 年的 CLA 签署趋势
```

### 贡献者分析示例

```
哪些企业对 openEuler 贡献最多？
openEuler 的 Top 10 个人贡献者
CANN 社区最活跃的开发者名单
```

### 跨社区对比示例

```
openEuler 和 CANN 社区的 PR 合并率对比
MindSpore 和 openGauss 的 Issue 关闭率对比
各社区的企业参与数量对比
```

更多使用示例请参考 [FEATURES.md](FEATURES.md)。

---

## 🛠️ 开发指南

## 安装

### 前置要求

- Python 3.8+
- 网络连接（调用远程 API：`https://datastat.osinfra.cn/server/`）

### 安装步骤

1. 从 GitHub 下载项目：

```bash
git clone https://github.com/zhongjun2/om-mcp.git
cd om-mcp
```

2. 安装依赖：

```bash
pip install -e .
```

3. 验证安装：

```bash
python -c "from server import mcp; print('ok')"
```

输出 `ok` 说明安装成功。

## 检查在claude中是否安装成功

```
claude

/mcp
─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
  Manage MCP servers
  1 server

    Project MCPs (/home/zj/claude/test/om-mcp/.mcp.json)
  ❯ om-metrics · ✔ connected
```
出现om-metrics表示安装成功


## 使用方式

在 Claude Desktop 中直接提问，MCP 工具会自动调用。例如：

```
查询 openeuler 社区的健康度评分
查询 openeuler 社区PR总数
```

## 开发

### 项目结构

```
om-mcp/
├── server.py            # MCP 服务器入口
├── lib/
│   └── http.py         # HTTP 请求封装
├── tools/
│   ├── health.py       # 社区健康度查询
│   ├── common.py       # 通用工具（社区列表）
│   ├── server_apis.py  # 服务端 API（社区列表、指标字典、热点仓库等）
│   ├── query_apis.py   # 查询 API（PR/Issue 聚合、按 SIG 统计等）
│   ├── cla_apis.py     # CLA 相关 API
│   └── project_apis.py # 项目 CI 指标
└── test/               # 测试目录
    ├── test_mcp.py     # 测试脚本
    └── README.md       # 测试说明
```

### 添加新工具

1. 在 `tools/` 目录下创建新的 Python 文件
2. 定义 `register(mcp: FastMCP)` 函数
3. 使用 `@mcp.tool()` 装饰器注册工具
4. 在 `server.py` 中导入并注册

示例：
```python
from mcp.server.fastmcp import FastMCP
from lib.http import get, post, extract_data

def register(mcp: FastMCP):
    @mcp.tool()
    async def my_new_tool(param: str) -> str:
        """工具描述"""
        result = await get("/api/endpoint")
        return f"结果: {result}"
```

### 测试

运行测试脚本验证所有功能：

```bash
cd test
python3 test_mcp.py
```

测试脚本会模拟真实使用场景，调用所有 MCP 工具并验证返回结果。详见 [test/README.md](test/README.md)。

---

## 🔧 故障排查

### MCP 服务器无法启动

1. 检查 Python 版本：`python3 --version`（需要 3.8+）
2. 检查依赖安装：`pip list | grep mcp`
3. 查看 Claude Desktop 日志

### 查询返回错误

1. 确认网络连接正常，可访问远程 API：`curl https://datastat.osinfra.cn/server/`
2. 检查社区名称是否正确（使用 `list_communities` 工具查看支持的社区）
3. 运行测试脚本验证：`cd test && python3 test_mcp.py`

### 常见错误

| 错误信息 | 原因 | 解决方案 |
|---------|------|---------|
| `ModuleNotFoundError: No module named 'mcp'` | MCP SDK 未安装 | 运行 `pip install "mcp[cli]"` |
| `Connection refused` | 无法访问远程 API | 检查网络连接和防火墙设置 |
| `Community not found` | 社区名称错误 | 使用 `list_communities` 查看支持的社区 |

---

## 📚 文档索引

| 文档 | 说明 |
|------|------|
| [FEATURES.md](FEATURES.md) | 完整功能列表和使用示例 |
| [INSTALL.md](INSTALL.md) | 详细安装指南（含虚拟环境配置） |
| [test/README.md](test/README.md) | 测试说明和故障排查 |

---

## 🔗 后端 API 说明

本 MCP 服务器调用远程 API 服务：
- **API 地址**：`https://datastat.osinfra.cn/server/`
- **修改方式**：编辑 `lib/http.py` 中的 `API_BASE_URL` 变量

---

## 📄 许可证

[MIT License](LICENSE)

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

贡献前请：
1. Fork 本项目
2. 创建特性分支：`git checkout -b feature/your-feature`
3. 提交更改：`git commit -m 'Add some feature'`
4. 推送到分支：`git push origin feature/your-feature`
5. 提交 Pull Request

---

<div align="center">

**om-metrics MCP Server** — 让开源社区数据查询更简单 📊

Made with ❤️ for Open Source Communities

</div>

