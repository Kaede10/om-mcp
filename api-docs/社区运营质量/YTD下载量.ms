{
  "properties" : { },
  "id" : "copy1773127835647d66022",
  "script" : null,
  "groupId" : "2e2220ca1c424052ba4fa20a1e7370f8",
  "name" : "YTD下载量",
  "createTime" : null,
  "updateTime" : 1773367013284,
  "lock" : null,
  "createBy" : null,
  "updateBy" : "admin",
  "path" : "/year_download",
  "method" : "GET",
  "parameters" : [ {
    "name" : "community",
    "value" : "mindie",
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
    "name" : "date",
    "value" : "1795689600000",
    "description" : "查询时间,格式为毫秒时间戳",
    "required" : false,
    "dataType" : "Long",
    "type" : null,
    "defaultValue" : "date > 0 && date <= 9999999999999",
    "validateType" : "expression",
    "error" : null,
    "expression" : null,
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 1,\n    \"message\": \"success\",\n    \"data\": {\n        \"download\": 63.2693000000000000\n    },\n    \"timestamp\": 1773365967222,\n    \"executeTime\": 7\n}",
  "description" : "根据输入的时间，返回从该时间所在年份的1月1日起至该时间点为止的下载总量。用于评估开源社区质量运营。",
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
          "name" : "count",
          "value" : "305",
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
      "value" : "1773128439297",
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
      "value" : "130",
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
SELECT COALESCE(SUM(download_day_increase), 0)/10000.0 AS download 
FROM dws_${community}_download_daily dodd 
WHERE created_at >= DATE_TRUNC('year', (to_timestamp(#{date}/1000) AT TIME ZONE 'Asia/Shanghai')::DATE)
  AND created_at <= (to_timestamp(#{date}/1000) AT TIME ZONE 'Asia/Shanghai')::DATE;
"""

var resp = db.select(sql)
return resp[0]