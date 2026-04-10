{
  "properties" : { },
  "id" : "7b698439e72b47819e23ffafcad26193",
  "script" : null,
  "groupId" : "1cc0849322d74468ab73c9ad0f14fc02",
  "name" : "SIG的组织成员信息",
  "createTime" : null,
  "updateTime" : 1775631784438,
  "lock" : null,
  "createBy" : "admin",
  "updateBy" : "admin",
  "path" : "/role/list",
  "method" : "GET",
  "parameters" : [ {
    "name" : "community",
    "value" : "openubmc",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "pattern",
    "error" : "community 参数非法",
    "expression" : "^[a-zA-Z]{1,32}$",
    "children" : null
  }, {
    "name" : "sig",
    "value" : "Infrastructure",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "pattern",
    "error" : "sig 格式非法",
    "expression" : "^[a-zA-Z0-9\\s_/-]+$",
    "children" : null
  } ],
  "options" : [ {
    "name" : "wrap_request_parameter",
    "value" : "disable-cache",
    "description" : "包装请求参数到一个变量中",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : "获取社区某个SIG的所有组织成员信息（属于社区组织架构成员的一部分）",
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
var sql_role = """
SELECT 
    role,
    jsonb_agg(
        jsonb_build_object(
            'user_login', user_login,
            'user_name', user_name,
            'email', email,
            'organization', organization
        )
    ) AS users
FROM (
    SELECT DISTINCT ON (role, user_login) 
        role, user_login, user_name, email, organization
    FROM fact_${community}_sig_user
    WHERE sig_name = #{sig}
      AND is_removed IS NULL
    ORDER BY role, user_login
) AS distinct_users
GROUP BY role;
"""
var resp = db.select(sql_role)
var ans = []
for (r in resp) {
    var item = {}
    item['role'] = r.role
    item['users'] = r.users == null ? null : r.users.value::json
    ans.add(item)
}
return ans 
