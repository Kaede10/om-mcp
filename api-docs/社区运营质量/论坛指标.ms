{
  "properties" : { },
  "id" : "ed53f8807e6b4c6ba8a135fb16a7b790",
  "script" : null,
  "groupId" : "2e2220ca1c424052ba4fa20a1e7370f8",
  "name" : "论坛指标",
  "createTime" : null,
  "updateTime" : 1773364848302,
  "lock" : null,
  "createBy" : null,
  "updateBy" : "admin",
  "path" : "/forum",
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
    "name" : "start",
    "value" : null,
    "description" : "查询范围开始时间，格式为毫秒时间戳",
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
    "description" : "查询范围结束时间，格式为毫秒时间戳",
    "required" : false,
    "dataType" : "Long",
    "type" : null,
    "defaultValue" : null,
    "validateType" : null,
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 1,\n    \"message\": \"success\",\n    \"data\": [{\n        \"count\": 2595,\n        \"avg_first_reply_time\": 21.23,\n        \"avg_closed_time\": 21.23\n    }],\n    \"timestamp\": 1773134517117,\n    \"executeTime\": 15\n}",
  "description" : "统计社区论坛汇总指标（平均首次响应时间、平均闭环时间）",
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
      "description" : "响应码",
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
      "description" : "响应消息",
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
      "description" : "响应数据",
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
          "name" : "count",
          "value" : "2595",
          "description" : "论坛帖子总数",
          "required" : false,
          "dataType" : "Integer",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "avg_first_reply_time",
          "value" : "21.23",
          "description" : "论坛帖子平均首次响应时间",
          "required" : false,
          "dataType" : "Double",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "avg_closed_time",
          "value" : "21.23",
          "description" : "论坛帖子平均闭环时间",
          "required" : false,
          "dataType" : "Double",
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
      "value" : "1773134517117",
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
      "value" : "15",
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
        count(*) as count, 
        ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY COALESCE(first_reply_duration, 0)) / 86400.0)::NUMERIC, 2) AS median_first_reply_time,
        ROUND((PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY COALESCE(closed_time, 0)) / 86400.0)::NUMERIC, 2) AS median_closed_time
FROM fact_${community}_forum_topic
<where>
    <if test="start != null and start != ''">
        AND created_at >= (to_timestamp(#{start}/1000) AT TIME ZONE 'Asia/Shanghai')::date
    </if>
    <if test="end != null and end != ''">
        AND created_at <= (to_timestamp(#{end}/1000) AT TIME ZONE 'Asia/Shanghai')::date
    </if>
</where>     
"""
var resp = db.select(sql)
return resp