{
  "properties" : { },
  "id" : "42742ef13cab4b90889c27fa6eb40ff3",
  "script" : null,
  "groupId" : "2e2220ca1c424052ba4fa20a1e7370f8",
  "name" : "有效评论数",
  "createTime" : null,
  "updateTime" : 1773385220767,
  "lock" : null,
  "createBy" : null,
  "updateBy" : "admin",
  "path" : "/valid_comment",
  "method" : "GET",
  "parameters" : [ {
    "name" : "community",
    "value" : "openeuler",
    "description" : "社区名称",
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
    "description" : "时间维度，如日、月、年",
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "pattern",
    "error" : null,
    "expression" : "^(day|month|year)$",
    "children" : null
  }, {
    "name" : "start",
    "value" : "1755689600000",
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
    "value" : "1795689600000",
    "description" : "查询范围结束时间,格式为毫秒时间戳",
    "required" : false,
    "dataType" : "Long",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  }, {
    "name" : "contrib_type",
    "value" : "",
    "description" : "issue评论还是pr评论",
    "required" : false,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "pattern",
    "error" : null,
    "expression" : "^(pr|issue)$",
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 1,\n    \"message\": \"success\",\n    \"data\": [{\n        \"stats_date\": \"2025-08-01\",\n        \"comments\": 874,\n        \"avg_comments\": 2\n    }, {\n        \"stats_date\": \"2025-09-01\",\n        \"comments\": 2174,\n        \"avg_comments\": 2\n    }, {\n        \"stats_date\": \"2025-10-01\",\n        \"comments\": 1138,\n        \"avg_comments\": 2\n    }, {\n        \"stats_date\": \"2025-11-01\",\n        \"comments\": 1322,\n        \"avg_comments\": 2\n    }, {\n        \"stats_date\": \"2025-12-01\",\n        \"comments\": 2676,\n        \"avg_comments\": 2\n    }, {\n        \"stats_date\": \"2026-01-01\",\n        \"comments\": 1603,\n        \"avg_comments\": 2\n    }, {\n        \"stats_date\": \"2026-02-01\",\n        \"comments\": 1163,\n        \"avg_comments\": 2\n    }, {\n        \"stats_date\": \"2026-03-01\",\n        \"comments\": 820,\n        \"avg_comments\": 2\n    }],\n    \"timestamp\": 1773385014617,\n    \"executeTime\": 191\n}",
  "description" : "查询指定社区的日/月/年度的有效评论/review数量，排除机器人发出的评论和命令型评论，适合：趋势分析、历史对比、汇总某年/某月数据。",
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
          "name" : "month_date",
          "value" : "2025-01-01",
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
          "name" : "comments",
          "value" : "7406",
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
      "value" : "1773128718749",
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
      "value" : "634",
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
SELECT date_trunc('${interval}', created_at)::date as stats_date, 
    COUNT(*) AS comments,
    (COUNT(*) / COUNT(DISTINCT html_url)) AS avg_comments
FROM dwm_${community}_user_interaction 
WHERE company <> 'robot'
    <if test="start != null and start != ''">
        AND created_at >= (to_timestamp(#{start}/1000) AT TIME ZONE 'Asia/Shanghai')::date
    </if>
    <if test="end != null and end != ''">
        AND created_at <= (to_timestamp(#{end}/1000) AT TIME ZONE 'Asia/Shanghai')::date
    </if>
    <if test="contrib_type != null and contrib_type != ''">
        AND contrib_type = #{contrib_type}
    </if>
GROUP BY date_trunc('${interval}', created_at)
ORDER BY date_trunc('${interval}', created_at) asc;
"""

var resp = db.select(sql)
return resp