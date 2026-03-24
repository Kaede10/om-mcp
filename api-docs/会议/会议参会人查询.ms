{
  "properties" : { },
  "id" : "9f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c",
  "script" : null,
  "groupId" : "9af308d96b55470faeda3c9b3357f836",
  "name" : "会议参会人查询",
  "createTime" : null,
  "updateTime" : 1774355387334,
  "lock" : null,
  "createBy" : "admin",
  "updateBy" : "admin",
  "path" : "/participants/info",
  "method" : "GET",
  "parameters" : [ {
    "name" : "community",
    "value" : "openeuler",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "pattern",
    "error" : "community 参数格式非法",
    "expression" : "^[a-zA-Z]{1,32}$",
    "children" : null
  }, {
    "name" : "meeting_id",
    "value" : "",
    "description" : "会议ID",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : null
  }, {
    "name" : "user_name",
    "value" : "",
    "description" : "参会人用户名",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : null
  }, {
    "name" : "page",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : "1",
    "validateType" : "expression",
    "error" : null,
    "expression" : "page > 0",
    "children" : null
  }, {
    "name" : "page_size",
    "value" : null,
    "description" : null,
    "required" : false,
    "dataType" : "Integer",
    "type" : null,
    "defaultValue" : "10",
    "validateType" : "expression",
    "error" : null,
    "expression" : "page_size <= 100 && page_size > 0",
    "children" : null
  }, {
    "name" : "sort",
    "value" : "meeting_id",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "meeting_id",
    "validateType" : "pattern",
    "error" : "sort 只能为 meeting_id、user_name",
    "expression" : "^(meeting_id|user_name)?$",
    "children" : null
  }, {
    "name" : "direction",
    "value" : "desc",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "desc",
    "validateType" : "pattern",
    "error" : "direction 只能为 asc 或 desc",
    "expression" : "^(asc|desc|ASC|DESC)?$",
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
  "requestBody" : null,
  "headers" : [ {
    "name" : "token",
    "value" : "",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "paths" : [ ],
  "responseBody" : null,
  "description" : null,
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
var off = (page - 1) * page_size

var table_name = `fact_${community}_meeting_participants`

var sort_field = not_blank(sort) ? '"' + sort + '"' : '"meeting_id"'
var sort_dir = not_blank(direction) ? direction.toLowerCase() : 'desc'

var sqlstr = """
SELECT
    "meeting_id",
    "user_name"
FROM
    ${table_name} t
WHERE
    1 = 1
    <if test="not_blank(meeting_id)">
        AND "meeting_id" = #{meeting_id}
    </if>
    <if test="not_blank(user_name)">
        AND "user_name" = #{user_name}
    </if>
ORDER BY ${sort_field} ${sort_dir}
LIMIT #{page_size} OFFSET #{off}
"""

var resp = db.select(sqlstr)
return resp
