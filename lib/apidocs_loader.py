import json
import os
from typing import List, Optional

from lib.template_loader import ParamDef, ToolTemplate

_SEPARATOR = "================================"
_APIDOCS_DIR = os.path.join(os.path.dirname(os.path.dirname(__file__)), "api-docs")


def load_apidocs_templates() -> List[ToolTemplate]:
    templates = []

    if not os.path.isdir(_APIDOCS_DIR):
        print("No api docs in path :{_APIDOCS_DIR}")
        return templates

    for group_dir in sorted(os.listdir(_APIDOCS_DIR)):
        group_path = os.path.join(_APIDOCS_DIR, group_dir)
        if not os.path.isdir(group_path):
            continue

        group_prefix = _load_group_prefix(group_path)

        for filename in sorted(os.listdir(group_path)):
            if not filename.endswith(".ms"):
                continue
            ms_path = os.path.join(group_path, filename)
            template = _parse_ms_file(ms_path, group_prefix)
            if template:
                templates.append(template)

    return templates


def _load_group_prefix(group_dir: str) -> str:
    group_json = os.path.join(group_dir, "group.json")
    if not os.path.exists(group_json):
        return ""
    with open(group_json, encoding="utf-8") as f:
        data = json.load(f)
    return data.get("path", "").rstrip("/")


def _parse_ms_file(path: str, group_prefix: str) -> Optional[ToolTemplate]:
    with open(path, encoding="utf-8") as f:
        content = f.read()

    json_part = content.split(_SEPARATOR)[0].strip()
    try:
        data = json.loads(json_part)
    except json.JSONDecodeError:
        return None

    ms_path = data.get("path", "")
    if not ms_path:
        return None

    full_path = group_prefix + "/" + ms_path.lstrip("/")
    http_method = data.get("method", "POST").lower()
    name = data.get("name", ms_path)
    description = data.get("description") or name

    tool_name = _path_to_tool_name(full_path)
    params = []
    params.extend(_infer_params(data.get("parameters"), "query"))
    request_body = data.get("requestBodyDefinition") or {}
    params.extend(_infer_params(request_body.get("children") or [], "body"))

    response_body = data.get("responseBodyDefinition") or {}
    response_config = _detect_response_config(response_body.get("children") or [])

    return ToolTemplate(
        name=tool_name,
        description=description,
        http_method=http_method,
        http_path=full_path,
        use_extract_data=True,
        path_params=[],
        constant_params={},
        params=params,
        empty_data_message="暂无数据",
        response_config=response_config,
    )


def _path_to_tool_name(path: str) -> str:
    parts = [p for p in path.strip("/").split("/") if p]
    return "get_" + "_".join(parts)

_TYPE_MAP = {
    "long": "int",
    "integer": "int",
    "int": "int",
    "double": "int",
    "float": "int",
    "number": "int",
    "string": "str",
    "integer": "int",
    "array": "list",
    "object": "dict",
}


def _infer_params(params_list: list, param_type: str) -> List[ParamDef]:
    params = []
    if not params_list:
        return params
    for item in params_list:
        data_type = _TYPE_MAP.get((item.get("dataType") or "").lower(), "str")

        params.append(ParamDef(
            name=item.get("name"),
            type=data_type,
            default=item.get("defaultValue"),
            required=item.get("required") or False,
            description=item.get("description") or "",
            body_key=item.get("name"),
            in_=param_type,
            conditional=True,
            community_map=False,
        ))
    return params


def _detect_response_config(response_body: list) -> dict:
    return {"type": "formatter"}

