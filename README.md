# om-metrics MCP Server

OpenMetrics MCP Server - 为 Claude Desktop 提供开源社区数据查询能力的 Model Context Protocol 服务器。

## 功能概述

本 MCP 服务器提供以下能力：
- 查询开源社区健康度指标
- 获取社区 PR/Issue 统计数据
- 查询 CLA 签署信息
- 获取企业和个人贡献排行
- 查询 CI/CD 指标数据

支持的社区包括：openEuler、openGauss、MindSpore、CANN、openUBMC 等 25+ 个开源社区。

## 安装

### 前置要求

- Python 3.8+
- 后端 MagicAPI 服务运行在 `http://localhost:9999`

### 安装步骤

1. 克隆仓库：
```bash
cd /home/zhongjun/claude/om-data/om-mcp
```

2. 安装依赖：
```bash
pip install -e .
```

或使用 uv：
```bash
uv pip install -e .
```

3. 验证安装：
```bash
python -m mcp
```

## 配置 Claude Desktop

在 Claude Desktop 配置文件中添加 MCP 服务器：

**macOS**: `~/Library/Application Support/Claude/claude_desktop_config.json`
**Windows**: `%APPDATA%\Claude\claude_desktop_config.json`

```json
{
  "mcpServers": {
    "om-metrics": {
      "command": "python",
      "args": ["-m", "mcp"],
      "cwd": "/home/zhongjun/claude/om-data/om-mcp"
    }
  }
}
```

重启 Claude Desktop 后即可使用。

## 使用方式

在 Claude Desktop 中直接提问，MCP 工具会自动调用。例如：

```
查询 openEuler 社区的健康度评分
openEuler 社区 2025 年每月的 PR 合并趋势
CANN 社区有多少个参与的企业？
查询 MindSpore 社区的 CLA 签署情况
```

## 开发

### 项目结构

```
om-mcp/
├── main.py              # MCP 服务器入口
├── lib/
│   └── http.py         # HTTP 请求封装
├── tools/
│   ├── health.py       # 社区健康度查询
│   ├── common.py       # 通用工具（社区列表）
│   ├── server_apis.py  # 服务端 API（社区列表、指标字典、热点仓库等）
│   ├── query_apis.py   # 查询 API（PR/Issue 聚合、按 SIG 统计等）
│   ├── cla_apis.py     # CLA 相关 API
│   └── project_apis.py # 项目 CI 指标
└── test_mcp.py         # 测试脚本
```

### 运行测试

```bash
python test_mcp.py
```

### 添加新工具

1. 在 `tools/` 目录下创建新的 Python 文件
2. 定义 `register(mcp: FastMCP)` 函数
3. 使用 `@mcp.tool()` 装饰器注册工具
4. 在 `main.py` 中导入并注册

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

## 后端 API 说明

本 MCP 服务器依赖后端 MagicAPI 服务，默认地址：`http://localhost:9999`

如需修改后端地址，编辑 `lib/http.py` 中的 `MAGIC_API_BASE_URL` 变量。

## 故障排查

### MCP 服务器无法启动

1. 检查 Python 版本：`python --version`（需要 3.8+）
2. 检查依赖安装：`pip list | grep mcp`
3. 查看 Claude Desktop 日志

### 查询返回错误

1. 确认后端 MagicAPI 服务运行正常：`curl http://localhost:9999`
2. 检查社区名称是否正确（使用 `list_communities` 工具查看支持的社区）
3. 查看 `test_mcp.py` 测试结果

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！
