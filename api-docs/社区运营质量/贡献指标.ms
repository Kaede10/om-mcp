{
  "properties" : { },
  "id" : "dff537f2baaa4c6eab941cd0c19239bf",
  "script" : null,
  "groupId" : "2e2220ca1c424052ba4fa20a1e7370f8",
  "name" : "贡献指标",
  "createTime" : null,
  "updateTime" : 1773365167908,
  "lock" : null,
  "createBy" : null,
  "updateBy" : "admin",
  "path" : "/contribute",
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
    "value" : "1797205600000",
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
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 1,\n    \"message\": \"success\",\n    \"data\": [{\n        \"month_date\": \"2025-12-01\",\n        \"activate_user\": 125,\n        \"prs\": 374,\n        \"merged_prs\": 319,\n        \"issues\": 173,\n        \"merged_pr_user\": 61\n    }, {\n        \"month_date\": \"2026-01-01\",\n        \"activate_user\": 397,\n        \"prs\": 489,\n        \"merged_prs\": 385,\n        \"issues\": 298,\n        \"merged_pr_user\": 68\n    }, {\n        \"month_date\": \"2026-02-01\",\n        \"activate_user\": 105,\n        \"prs\": 322,\n        \"merged_prs\": 283,\n        \"issues\": 196,\n        \"merged_pr_user\": 62\n    }, {\n        \"month_date\": \"2026-03-01\",\n        \"activate_user\": 95,\n        \"prs\": 185,\n        \"merged_prs\": 148,\n        \"issues\": 165,\n        \"merged_pr_user\": 44\n    }],\n    \"timestamp\": 1773219233763,\n    \"executeTime\": null\n}",
  "description" : "查询指定社区的日/月/年度的贡献数据，包含提交的 PR 数、合并的 PR 数、提交的 Issue 数、活跃用户数、合并 PR 用户数。\n返回完整日/月/年度数据列表。\n适合：趋势分析、历史对比、汇总某年/某月数据。\n注意：不同周期用户有重复，不能将日期维度的用户数直接相加。",
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
          "name" : "activate_user",
          "value" : "868",
          "description" : "当期活跃开发者人数",
          "required" : false,
          "dataType" : "Integer",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "prs",
          "value" : "3276",
          "description" : "提交的pr总数",
          "required" : false,
          "dataType" : "Integer",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "merged_prs",
          "value" : "2516",
          "description" : "合并的pr总数",
          "required" : false,
          "dataType" : "Integer",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "issues",
          "value" : "2552",
          "description" : "提交的issue总数",
          "required" : false,
          "dataType" : "Integer",
          "type" : null,
          "defaultValue" : null,
          "validateType" : "",
          "error" : "",
          "expression" : "",
          "children" : [ ]
        }, {
          "name" : "merged_pr_user",
          "value" : "340",
          "description" : "当期合并的pr用户",
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
      "value" : "1773143455111",
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
      "value" : "102",
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
SELECT date_trunc('${interval}', date)::date as month_date, 
       count(distinct user_login) as activate_user, 
       sum(pr_incre) as prs,
       sum(merged_pr_incre) as merged_prs, 
       sum(issue_incre) as issues, 
       count(distinct user_login) filter (where merged_pr_incre > 0) as merged_pr_user
FROM dws_${community}_contribute_repo_user_daily
WHERE 1 = 1
    <if test="start != null and start != ''">
        AND date >= (to_timestamp(#{start}/1000) AT TIME ZONE 'Asia/Shanghai')::date
    </if>
    <if test="end != null and end != ''">
        AND date <= (to_timestamp(#{end}/1000) AT TIME ZONE 'Asia/Shanghai')::date
    </if>
GROUP BY date_trunc('${interval}', date)
ORDER BY date_trunc('${interval}', date) asc;
"""

var resp = db.select(sql)
return resp