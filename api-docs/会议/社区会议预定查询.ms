{
  "properties" : { },
  "id" : "7a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d",
  "script" : null,
  "groupId" : "9af308d96b55470faeda3c9b3357f836",
  "name" : "社区会议预定查询",
  "createTime" : null,
  "updateTime" : 1774355687252,
  "lock" : null,
  "createBy" : "admin",
  "updateBy" : "admin",
  "path" : "/info",
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
    "name" : "sig_name",
    "value" : "",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : null
  }, {
    "name" : "topic",
    "value" : "",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : null
  }, {
    "name" : "sponsor",
    "value" : "",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : null
  }, {
    "name" : "created_after",
    "value" : "",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "pattern",
    "error" : "created_after 格式应为 yyyy-MM-dd 或 yyyy-MM-dd HH:mm:ss",
    "expression" : "^(\\d{4}-\\d{2}-\\d{2}( \\d{2}:\\d{2}:\\d{2})?)?$",
    "children" : null
  }, {
    "name" : "created_before",
    "value" : "",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "pattern",
    "error" : "created_before 格式应为 yyyy-MM-dd 或 yyyy-MM-dd HH:mm:ss",
    "expression" : "^(\\d{4}-\\d{2}-\\d{2}( \\d{2}:\\d{2}:\\d{2})?)?$",
    "children" : null
  }, {
    "name" : "sort",
    "value" : "created_at",
    "description" : null,
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : "created_at",
    "validateType" : "pattern",
    "error" : "sort 只能为 created_at、start、topic",
    "expression" : "^(created_at|start|topic)?$",
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
  "requestBody" : "",
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

var table_name = `fact_${community}_meeting_info`

var sort_field = not_blank(sort) ? '"' + sort + '"' : '"created_at"'
var sort_dir = not_blank(direction) ? direction.toLowerCase() : 'desc'

var sqlstr = """
SELECT
    "meeting_id",
    "sponsor",
    "sig_name",
    "community",
    "topic",
    "created_at",
    "start",
    "end",
    "etherpad",
    "email_list",
    "mid",
    "join_url",
    "agenda",
    "m_id",
    "platform"
FROM
    ${table_name} t
WHERE
    1 = 1
    <if test="not_blank(sig_name)">
        AND "sig_name" = #{sig_name}
    </if>
    <if test="not_blank(topic)">
        AND "topic" = #{topic}
    </if>
    <if test="not_blank(sponsor)">
        AND "sponsor" = #{sponsor}
    </if>
    <if test="not_blank(created_after)">
        AND "created_at" >= #{created_after}::timestamptz
    </if>
    <if test="not_blank(created_before)">
        AND "created_at" < #{created_before}::timestamptz
    </if>
    AND "is_removed" IS NULL
ORDER BY ${sort_field} ${sort_dir}
LIMIT #{page_size} OFFSET #{off}
"""

var resp = db.select(sqlstr)

for (it in resp) {
    for (key, value in it) {
        if (key == 'agenda' || key == 'email_list' || key == 'topic') {
            it[key] = value != null ? value::json : null
        }
    }
}

return resp
