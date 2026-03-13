{
  "properties" : { },
  "id" : "9baad7c69b5248588d6e23e74485a1ad",
  "script" : null,
  "groupId" : "2e2220ca1c424052ba4fa20a1e7370f8",
  "name" : "TOPN用户留存人数",
  "createTime" : null,
  "updateTime" : 1773367242261,
  "lock" : null,
  "createBy" : null,
  "updateBy" : "admin",
  "path" : "/user_retention",
  "method" : "GET",
  "parameters" : [ {
    "name" : "community",
    "value" : "mindie",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "interval",
    "value" : "month",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "start",
    "value" : "1765689600000",
    "description" : "查询范围开始时间,格式为毫秒时间戳",
    "required" : false,
    "dataType" : "Long",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "end",
    "value" : null,
    "description" : "查询范围结束时间,格式为毫秒时间戳",
    "required" : false,
    "dataType" : "Long",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
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
  "responseBody" : "{\n    \"code\": 1,\n    \"message\": \"success\",\n    \"data\": [{\n        \"stats_date\": \"2026-01-01\",\n        \"user_count\": 40\n    }, {\n        \"stats_date\": \"2026-02-01\",\n        \"user_count\": 30\n    }, {\n        \"stats_date\": \"2026-03-01\",\n        \"user_count\": 16\n    }],\n    \"timestamp\": 1773218889167,\n    \"executeTime\": 173\n}",
  "description" : "查询指定社区的日/月/年度的开发者留存情况，适合：趋势分析、历史对比、汇总年度/月度数据。",
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : {
    "name" : "",
    "value" : "",
    "description" : "",
    "required" : false,
    "dataType" : "Object",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "",
    "error" : "",
    "expression" : "",
    "children" : [ {
      "name" : "code",
      "value" : "1",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "message",
      "value" : "success",
      "description" : "",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "data",
      "value" : "",
      "description" : "",
      "required" : false,
      "dataType" : "Array",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ {
        "name" : "",
        "value" : "",
        "description" : "",
        "required" : false,
        "dataType" : "Object",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ {
          "name" : "stats_date",
          "value" : "2026-01-01",
          "description" : "",
          "required" : false,
          "dataType" : "String",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "user_count",
          "value" : "191",
          "description" : "",
          "required" : false,
          "dataType" : "Integer",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        } ]
      } ]
    }, {
      "name" : "timestamp",
      "value" : "1773218851280",
      "description" : "",
      "required" : false,
      "dataType" : "Long",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "executeTime",
      "value" : "33",
      "description" : "",
      "required" : false,
      "dataType" : "Integer",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    } ]
  }
}
================================
community = community.toLowerCase()
var sql = """
SELECT 
    stats_date,
    COUNT(DISTINCT user_login) AS user_count
FROM (
    SELECT 
        DATE_TRUNC('${interval}', date)::DATE AS stats_date,
        user_login,
        SUM(merged_pr_incre * 5 + issue_incre * 3 + comment_incre * 1) AS score
    FROM dws_${community}_contribute_repo_user_daily
    WHERE 1 = 1
        <if test="start != null and start != ''">
            AND date >= (to_timestamp(#{start}/1000) AT TIME ZONE 'Asia/Shanghai')::date
        </if>
        <if test="end != null and end != ''">
            AND date <= (to_timestamp(#{end}/1000) AT TIME ZONE 'Asia/Shanghai')::date
        </if>
    GROUP BY DATE_TRUNC('${interval}', date)::DATE, user_login
) t
WHERE score >= 50
GROUP BY stats_date
ORDER BY stats_date;
"""

var resp = db.select(sql)
return resp