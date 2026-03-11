{
  "properties" : { },
  "id" : "copy1763688104444d95918",
  "script" : null,
  "groupId" : "39c33765c93e4af089275fbe9ae18d07",
  "name" : "issue汇总分页",
  "createTime" : null,
  "updateTime" : 1773126761681,
  "lock" : null,
  "createBy" : null,
  "updateBy" : "admin",
  "path" : "/issues/agg",
  "method" : "POST",
  "parameters" : [ ],
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
  "requestBody" : "{\r\n    \"start\":1735660800000,\r\n    \"end\":1767110400000,\r\n    \"group_dim\": \"sub_community\",\r\n    \"community\":\"mindall\",\r\n    \"issue_type\": \"\",\r\n    \"issue_type_list\": [],\r\n    \"namespace\":\"\",\r\n    \"repo_path\":\"\",\r\n    \"source\": \"\",\r\n    \"internalList\": [],\r\n    \"private\": \"false\",\r\n    \"asc\":\"one_day_response_ratio\",\r\n    \"desc\":\"\"\r\n}",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 1,\n    \"message\": \"success\",\n    \"data\": {\n        \"total_count\": 10,\n        \"total_page\": 1,\n        \"list\": [{\n            \"sub_community\": \"mindseriessdk\",\n            \"issue_type\": \"All\",\n            \"count\": 585,\n            \"open_count\": 1,\n            \"week_new_count\": 0,\n            \"unresponse_open_count\": 0,\n            \"closed_count\": 628,\n            \"unclosed_count\": 1,\n            \"closed_ratio\": 0.9983,\n            \"avg_first_reply_time\": 62.47,\n            \"avg_closed_time\": 70.04,\n            \"avg_overdue_first_reply_time\": 61.68,\n            \"avg_overdue_closed_time\": 64.24,\n            \"one_day_response_ratio\": 0.06,\n            \"eight_hour_response_ratio\": 0.04,\n            \"five_day_closed_ratio\": 0.40,\n            \"seven_day_closed_ratio\": 0.43,\n            \"comment_num\": 0.40\n        }, {\n            \"sub_community\": \"mindie\",\n            \"issue_type\": \"All\",\n            \"count\": 118,\n            \"open_count\": 22,\n            \"week_new_count\": 5,\n            \"unresponse_open_count\": 0,\n            \"closed_count\": 31,\n            \"unclosed_count\": 22,\n            \"closed_ratio\": 0.8136,\n            \"avg_first_reply_time\": 29.09,\n            \"avg_closed_time\": 38.95,\n            \"avg_overdue_first_reply_time\": 28.16,\n            \"avg_overdue_closed_time\": 22.35,\n            \"one_day_response_ratio\": 0.07,\n            \"eight_hour_response_ratio\": 0.03,\n            \"five_day_closed_ratio\": 0.10,\n            \"seven_day_closed_ratio\": 0.17,\n            \"comment_num\": 0.67\n        }, {\n            \"sub_community\": \"mindcluster\",\n            \"issue_type\": \"All\",\n            \"count\": 178,\n            \"open_count\": 34,\n            \"week_new_count\": 1,\n            \"unresponse_open_count\": 13,\n            \"closed_count\": 151,\n            \"unclosed_count\": 34,\n            \"closed_ratio\": 0.8090,\n            \"avg_first_reply_time\": 73.92,\n            \"avg_closed_time\": 104.54,\n            \"avg_overdue_first_reply_time\": 72.99,\n            \"avg_overdue_closed_time\": 91.65,\n            \"one_day_response_ratio\": 0.10,\n            \"eight_hour_response_ratio\": 0.05,\n            \"five_day_closed_ratio\": 0.13,\n            \"seven_day_closed_ratio\": 0.16,\n            \"comment_num\": 1.66\n        }, {\n            \"sub_community\": \"triton\",\n            \"issue_type\": \"All\",\n            \"count\": 241,\n            \"open_count\": 144,\n            \"week_new_count\": 7,\n            \"unresponse_open_count\": 94,\n            \"closed_count\": 77,\n            \"unclosed_count\": 144,\n            \"closed_ratio\": 0.4025,\n            \"avg_first_reply_time\": 86.95,\n            \"avg_closed_time\": 126.95,\n            \"avg_overdue_first_reply_time\": 86.09,\n            \"avg_overdue_closed_time\": 119.70,\n            \"one_day_response_ratio\": 0.16,\n            \"eight_hour_response_ratio\": 0.13,\n            \"five_day_closed_ratio\": 0.11,\n            \"seven_day_closed_ratio\": 0.13,\n            \"comment_num\": 1.00\n        }, {\n            \"sub_community\": \"pta\",\n            \"issue_type\": \"All\",\n            \"count\": 1937,\n            \"open_count\": 1120,\n            \"week_new_count\": 13,\n            \"unresponse_open_count\": 1077,\n            \"closed_count\": 1068,\n            \"unclosed_count\": 1120,\n            \"closed_ratio\": 0.4218,\n            \"avg_first_reply_time\": 99.00,\n            \"avg_closed_time\": 105.48,\n            \"avg_overdue_first_reply_time\": 98.16,\n            \"avg_overdue_closed_time\": 81.87,\n            \"one_day_response_ratio\": 0.17,\n            \"eight_hour_response_ratio\": 0.12,\n            \"five_day_closed_ratio\": 0.15,\n            \"seven_day_closed_ratio\": 0.19,\n            \"comment_num\": 0.56\n        }, {\n            \"sub_community\": \"vllm\",\n            \"issue_type\": \"All\",\n            \"count\": 1601,\n            \"open_count\": 752,\n            \"week_new_count\": 41,\n            \"unresponse_open_count\": 321,\n            \"closed_count\": 794,\n            \"unclosed_count\": 752,\n            \"closed_ratio\": 0.5303,\n            \"avg_first_reply_time\": 44.38,\n            \"avg_closed_time\": 99.64,\n            \"avg_overdue_first_reply_time\": 43.71,\n            \"avg_overdue_closed_time\": 91.53,\n            \"one_day_response_ratio\": 0.34,\n            \"eight_hour_response_ratio\": 0.23,\n            \"five_day_closed_ratio\": 0.17,\n            \"seven_day_closed_ratio\": 0.19,\n            \"comment_num\": 2.76\n        }, {\n            \"sub_community\": \"ascendnpuir\",\n            \"issue_type\": \"All\",\n            \"count\": 194,\n            \"open_count\": 80,\n            \"week_new_count\": 15,\n            \"unresponse_open_count\": 31,\n            \"closed_count\": 76,\n            \"unclosed_count\": 80,\n            \"closed_ratio\": 0.5876,\n            \"avg_first_reply_time\": 23.40,\n            \"avg_closed_time\": 74.17,\n            \"avg_overdue_first_reply_time\": 22.65,\n            \"avg_overdue_closed_time\": 64.48,\n            \"one_day_response_ratio\": 0.36,\n            \"eight_hour_response_ratio\": 0.26,\n            \"five_day_closed_ratio\": 0.11,\n            \"seven_day_closed_ratio\": 0.13,\n            \"comment_num\": 2.04\n        }, {\n            \"sub_community\": \"tilelang\",\n            \"issue_type\": \"All\",\n            \"count\": 56,\n            \"open_count\": 37,\n            \"week_new_count\": 7,\n            \"unresponse_open_count\": 9,\n            \"closed_count\": 17,\n            \"unclosed_count\": 37,\n            \"closed_ratio\": 0.3393,\n            \"avg_first_reply_time\": 16.99,\n            \"avg_closed_time\": 73.73,\n            \"avg_overdue_first_reply_time\": 16.31,\n            \"avg_overdue_closed_time\": 67.82,\n            \"one_day_response_ratio\": 0.36,\n            \"eight_hour_response_ratio\": 0.25,\n            \"five_day_closed_ratio\": 0.18,\n            \"seven_day_closed_ratio\": 0.18,\n            \"comment_num\": 1.41\n        }, {\n            \"sub_community\": \"mindspeed\",\n            \"issue_type\": \"All\",\n            \"count\": 782,\n            \"open_count\": 117,\n            \"week_new_count\": 6,\n            \"unresponse_open_count\": 30,\n            \"closed_count\": 559,\n            \"unclosed_count\": 117,\n            \"closed_ratio\": 0.8504,\n            \"avg_first_reply_time\": 23.14,\n            \"avg_closed_time\": 69.38,\n            \"avg_overdue_first_reply_time\": 22.45,\n            \"avg_overdue_closed_time\": 60.65,\n            \"one_day_response_ratio\": 0.40,\n            \"eight_hour_response_ratio\": 0.27,\n            \"five_day_closed_ratio\": 0.15,\n            \"seven_day_closed_ratio\": 0.18,\n            \"comment_num\": 2.45\n        }, {\n            \"sub_community\": \"mindstudio\",\n            \"issue_type\": \"All\",\n            \"count\": 268,\n            \"open_count\": 4,\n            \"week_new_count\": 1,\n            \"unresponse_open_count\": 0,\n            \"closed_count\": 254,\n            \"unclosed_count\": 4,\n            \"closed_ratio\": 0.9851,\n            \"avg_first_reply_time\": 5.54,\n            \"avg_closed_time\": 13.76,\n            \"avg_overdue_first_reply_time\": 4.90,\n            \"avg_overdue_closed_time\": 7.59,\n            \"one_day_response_ratio\": 0.57,\n            \"eight_hour_response_ratio\": 0.29,\n            \"five_day_closed_ratio\": 0.33,\n            \"seven_day_closed_ratio\": 0.52,\n            \"comment_num\": 2.83\n        }]\n    },\n    \"timestamp\": 1773126487130,\n    \"executeTime\": 16\n}",
  "description" : "issue贡献汇总信息分页查询接口（支持全社区/子社区/仓库维度）返回指标：issue总数、开启issue总数、本周新增issue总数、未响应issue总数、未关闭issue总数、关闭率、平均首次响应时间（天）、平均关闭时间（天）、平均首次响应超时时间（天）、平均关闭超时时间（天）、24小时响应率、8小时响应率、5天内关闭率、7天内关闭率、评论互动数量",
  "requestBodyDefinition" : {
    "name" : "root",
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
      "name" : "start",
      "value" : "1735660800000",
      "description" : "开始时间",
      "required" : true,
      "dataType" : "Long",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "end",
      "value" : "1767110400000",
      "description" : "结束时间",
      "required" : true,
      "dataType" : "Long",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "group_dim",
      "value" : "sub_community",
      "description" : "聚合维度，如果不填则是全社区汇总",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "community",
      "value" : "mindall",
      "description" : "社区，查询所属社区",
      "required" : true,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "issue_type",
      "value" : "",
      "description" : "issue类型",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "issue_type_list",
      "value" : "",
      "description" : "issue类型数组",
      "required" : false,
      "dataType" : "Array",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "namespace",
      "value" : "",
      "description" : "namespace",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "repo_path",
      "value" : "",
      "description" : "仓库路径",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "source",
      "value" : "",
      "description" : "资源平台：gitee\\gitcode\\github",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "internalList",
      "value" : "",
      "description" : "内外部数组",
      "required" : false,
      "dataType" : "Array",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "private",
      "value" : "false",
      "description" : "公私仓：public-公仓，private-私仓",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "asc",
      "value" : "one_day_response_ratio",
      "description" : "正序排列字段",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    }, {
      "name" : "desc",
      "value" : "",
      "description" : "倒叙排列字段",
      "required" : false,
      "dataType" : "String",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ ]
    } ]
  },
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
      "dataType" : "Object",
      "type" : null,
      "defaultValue" : null,
      "validateType" : "",
      "error" : "",
      "expression" : "",
      "children" : [ {
        "name" : "total_count",
        "value" : "10",
        "description" : "数据总数",
        "required" : false,
        "dataType" : "Integer",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ ]
      }, {
        "name" : "total_page",
        "value" : "1",
        "description" : "数据总页数",
        "required" : false,
        "dataType" : "Integer",
        "type" : null,
        "defaultValue" : null,
        "validateType" : "",
        "error" : "",
        "expression" : "",
        "children" : [ ]
      }, {
        "name" : "list",
        "value" : "",
        "description" : "数据列表",
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
            "name" : "sub_community",
            "value" : "mindseriessdk",
            "description" : "子社区/社区",
            "required" : false,
            "dataType" : "String",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "issue_type",
            "value" : "All",
            "description" : "issue类型，all-代表全类型",
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
            "value" : "585",
            "description" : "issue总数",
            "required" : false,
            "dataType" : "Integer",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "open_count",
            "value" : "1",
            "description" : "开启issue总数",
            "required" : false,
            "dataType" : "Integer",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "week_new_count",
            "value" : "0",
            "description" : "本周新增issue数",
            "required" : false,
            "dataType" : "Integer",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "unresponse_open_count",
            "value" : "0",
            "description" : "未响应issue总数",
            "required" : false,
            "dataType" : "Integer",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "closed_count",
            "value" : "628",
            "description" : "关闭issue总数",
            "required" : false,
            "dataType" : "Integer",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "unclosed_count",
            "value" : "1",
            "description" : "未关闭issue总数",
            "required" : false,
            "dataType" : "Integer",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "closed_ratio",
            "value" : "0.9983",
            "description" : "关闭率",
            "required" : false,
            "dataType" : "Double",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "avg_first_reply_time",
            "value" : "62.47",
            "description" : "平均首次响应时间，单位天",
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
            "value" : "70.04",
            "description" : "平均关闭时间，单位天",
            "required" : false,
            "dataType" : "Double",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "avg_overdue_first_reply_time",
            "value" : "61.68",
            "description" : "平均首次响应超时时间，单位天",
            "required" : false,
            "dataType" : "Double",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "avg_overdue_closed_time",
            "value" : "64.24",
            "description" : "平均关闭超时时间，单位天",
            "required" : false,
            "dataType" : "Double",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "one_day_response_ratio",
            "value" : "0.06",
            "description" : "24小时响应率",
            "required" : false,
            "dataType" : "Double",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "eight_hour_response_ratio",
            "value" : "0.04",
            "description" : "8小时响应率",
            "required" : false,
            "dataType" : "Double",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "five_day_closed_ratio",
            "value" : "0.40",
            "description" : "5天内关闭率",
            "required" : false,
            "dataType" : "Double",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "seven_day_closed_ratio",
            "value" : "0.43",
            "description" : "7天内关闭率",
            "required" : false,
            "dataType" : "Double",
            "type" : null,
            "defaultValue" : null,
            "validateType" : "",
            "error" : "",
            "expression" : "",
            "children" : [ ]
          }, {
            "name" : "comment_num",
            "value" : "0.40",
            "description" : "评论互动数量",
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
      } ]
    }, {
      "name" : "timestamp",
      "value" : "1773126487130",
      "description" : "响应时间戳",
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
      "value" : "16",
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
import '@/util/timestamp2Date' as timestamp2Date;
import  magic;
Date start = null;
if (body.start != null and body.start != '') {
    start = timestamp2Date(body.start);
}
Date end = null;
if (body.end != null and body.end != '') {
    end = timestamp2Date(body.end);
}
Date today = end
// 最近7天
LocalDate last7Start = today.minusDays(6);
LocalDate last7End = today;
var sortList = ["count","open_count","week_new_count","unresponse_open_count","unclosed_count","closed_ratio","avg_closed_time","avg_first_reply_time","one_day_response_ratio","eight_hour_response_ratio","five_day_closed_ratio","seven_day_closed_ratio","comment_num"]
// 聚合维度
var group_dim = body.group_dim;
// 社区
var community = body.community;
// 子社区
var no_sub_community = body.no_sub_community;
// 组织
var namespace = body.namespace;
// 服务平台
var source = body.source;
// 内外部
var internalList = body.internalList;
// 是否私仓
var private = body.private;
// Issue类型
var issue_type = body.issue_type;
// Issue类型数组
var issueTypeList = body.issue_type_list;
var issueTypes = null;
if (issueTypeList != null and issueTypeList.size() > 0){
    issueTypes = String.join(",", issueTypeList);
}
// 仓库
var repo_path = body.repo_path;
// 责任人
var assginee = body.assginee;
// page param
var page_num = 1;
if (body.pageNum != null and body.pageNum != ""){
    page_num = body.pageNum;
}
if (body.page_num != null and body.page_num != ""){
    page_num = body.page_num;
}
var page_size = 10;
if (body.pageSize != null and body.pageSize != ""){
    page_size = body.pageSize;
}
if (body.page_size != null and body.page_size != ""){
    page_size = body.page_size;
}

var offset = (page_num - 1) * page_size
var order_by_set = new HashSet()
var order_asc = "";
if (body.asc != null and body.asc != "") {
    var asc_arr = body.asc.split(",");
    for(index,item in asc_arr){
        if (sortList.contains(item)){
            order_by_set.add(item + " asc");
        }
    }
}
var order_desc = "";
if (body.desc != null and body.desc != "") {
    var desc_arr = body.desc.split(",");
    for(index,item in desc_arr){
        if (sortList.contains(item)){
            order_by_set.add(item + " desc");
        }
    }
}

var order_by = "";
if (order_by_set.size() > 0){
    order_by = order_by_set.join(",");
}

var contributeTable = "dws_" + community + "_issue_contribute_repo_daily";
var repoTable = "fact_" + community + "_repo";
var communityTable = "fact_community_structure";

var sql = """
WITH last_week_data AS (
    SELECT
        COALESCE(sum(open_issue_incre), 0) as week_new_count
    FROM ${contributeTable}
    <where>
        date >= #{last7Start} and date <= #{last7End} and internal is not null
        <if test="no_sub_community != null and no_sub_community != ''">
            and sub_community != #{no_sub_community}
        </if>
        <if test="namespace != null and namespace != ''">
            and namespace LIKE CONCAT('%', #{namespace}, '%')
        </if>
        <if test="repo_path != null and repo_path != ''">
            and repo_path LIKE CONCAT('%', #{repo_path}, '%')
        </if>
        <if test="issue_type != null and issue_type != ''">
            and super_issue_type = #{issue_type}
        </if>
        <if test="issueTypeList != null and issueTypeList.size() > 0">
            and super_issue_type in
            <foreach collection="issueTypeList" item="item" open="(" separator="," close=")">
                #{item}
            </foreach>
        </if>
        <if test="source != null and source != ''">
            and source = #{source}
        </if>
        <if test="private != null and private != ''">
            and private = #{private}
        </if>
        <if test="internalList != null and internalList.size() > 0">
            and internal in
            <foreach collection="internalList" item="item" open="(" separator="," close=")">
                #{item}
            </foreach>
        </if>
    </where>
),
contribute_data AS (
    SELECT
        COALESCE(sum(issue_incre), 0) as count, COALESCE(sum(open_issue_incre), 0) as open_count,
        COALESCE(sum(unresponse_open_issue_incre), 0) as unresponse_open_count, 
        COALESCE(sum(closed_issue_incre), 0) as closed_count, 
        COALESCE(sum(open_issue_incre), 0) + COALESCE(sum(progressing_issue_incre), 0) as unclosed_count, 
        ROUND(
            CASE
                WHEN sum(issue_incre) = 0 THEN 0
                ELSE (sum(issue_incre) - sum(open_issue_incre) - sum(progressing_issue_incre))::NUMERIC / sum(issue_incre)
            END::NUMERIC , 4
        ) as closed_ratio,
        ROUND(
            CASE
                WHEN sum(issue_incre) = 0 THEN 0
                ELSE sum(first_reply_time)::NUMERIC / sum(issue_incre) / 86400
            END::NUMERIC , 2
        ) as avg_first_reply_time,
        ROUND(
            CASE
                WHEN sum(issue_incre) = 0 THEN 0
                ELSE sum(closed_time)::NUMERIC / sum(issue_incre) / 86400
            END::NUMERIC , 2
        ) as avg_closed_time,
        ROUND(
            CASE
                WHEN sum(issue_incre) = 0 THEN 0
                ELSE sum(overdue_first_reply_time)::NUMERIC / sum(issue_incre) / 86400
            END::NUMERIC , 2
        ) as avg_overdue_first_reply_time,
        ROUND(
            CASE
                WHEN sum(issue_incre) = 0 THEN 0
                ELSE sum(overdue_closed_time)::NUMERIC / sum(issue_incre) / 86400
            END::NUMERIC , 2
        ) as avg_overdue_closed_time,
        ROUND(
            CASE
                WHEN sum(issue_incre) = 0 THEN 0
                ELSE sum(eight_hour_response_issue_incre)::NUMERIC / sum(issue_incre)
            END::NUMERIC , 2
        ) as eight_hour_response_ratio,
        ROUND(
            CASE
                WHEN sum(issue_incre) = 0 THEN 0
                ELSE sum(one_day_response_issue_incre)::NUMERIC / sum(issue_incre)
            END::NUMERIC , 2
        ) as one_day_response_ratio,
        ROUND(
            CASE
                WHEN sum(issue_incre) = 0 THEN 0
                ELSE sum(five_day_closed_issue_incre)::NUMERIC / sum(issue_incre)
            END::NUMERIC , 2
        ) as five_day_closed_ratio,
        ROUND(
            CASE
                WHEN sum(issue_incre) = 0 THEN 0
                ELSE sum(seven_day_closed_issue_incre)::NUMERIC / sum(issue_incre)
            END::NUMERIC , 2
        ) as seven_day_closed_ratio,
        ROUND(
            CASE
                WHEN sum(issue_incre) = 0 THEN 0
                ELSE sum(comment_num)::NUMERIC / sum(issue_incre)
            END::NUMERIC , 2
        ) as comment_num
    FROM ${contributeTable}
    <where>
        <if test="start != null ">
            and date >= #{start}
        </if>
        <if test="end != null ">
            and date <= #{end}
        </if>
        <if test="no_sub_community != null and no_sub_community != ''">
            and sub_community != #{no_sub_community}
        </if>
        <if test="namespace != null and namespace != ''">
            and namespace LIKE CONCAT('%', #{namespace}, '%')
        </if>
        <if test="repo_path != null and repo_path != ''">
            and repo_path LIKE CONCAT('%', #{repo_path}, '%')
        </if>
        <if test="issue_type != null and issue_type != ''">
            and super_issue_type = #{issue_type}
        </if>
        <if test="issueTypeList != null and issueTypeList.size() > 0">
            and super_issue_type in
            <foreach collection="issueTypeList" item="item" open="(" separator="," close=")">
                #{item}
            </foreach>
        </if>
        <if test="source != null and source != ''">
            and source = #{source}
        </if>
        <if test="private != null and private != ''">
            and private = #{private}
        </if>
        <if test="internalList != null and internalList.size() > 0">
            and internal in
            <foreach collection="internalList" item="item" open="(" separator="," close=")">
                #{item}
            </foreach>
        </if>
    </where>
)
SELECT 
    *, 
    (select count(1) from contribute_data) as total_count, 
    CEIL((select count(1) from contribute_data)::numeric/#{page_size}) as total_page
FROM 
    contribute_data, last_week_data
<if test="order_by != null and order_by != ''">
    ORDER BY ${order_by}
</if>
LIMIT #{page_size} OFFSET #{offset}
""";
if (group_dim != null and group_dim != ''){
    sql = """
        WITH dim as (
            <if test="group_dim == 'sub_community'">
                SELECT name as sub_community FROM ${communityTable} where parent_name = #{community} and status = 'active'
            </if>
            <if test="group_dim == 'repo'">
                SELECT namespace, repo_path, html_url as repo_url from ${repoTable} where is_hide is null
                <if test="source != null and source != ''">
                    and code_platform = #{source}
                </if>
                <if test="private != null and private != ''">
                    and private = #{private}
                </if>
                <if test="repo_path != null and repo_path != ''">
                    and repo_path LIKE CONCAT('%', #{repo_path}, '%')
                </if>
            </if>
        ),
        last_week_data AS (
            SELECT
                <if test="group_dim == 'sub_community'">
                    sub_community,   
                </if>     
                <if test="group_dim == 'repo'">
                    namespace, repo_path, repo_url,
                </if>       
                <if test="issue_type != null and issue_type != ''">
                    super_issue_type as issue_type,
                </if>
                COALESCE(sum(open_issue_incre), 0) as week_new_count
            FROM ${contributeTable}
            <where>
                date >= #{last7Start} and date <= #{last7End}
                <if test="namespace != null and namespace != ''">
                    and namespace LIKE CONCAT('%', #{namespace}, '%')
                </if>
                <if test="repo_path != null and repo_path != ''">
                    and repo_path LIKE CONCAT('%', #{repo_path}, '%')
                </if>
                <if test="issue_type != null and issue_type != ''">
                    and super_issue_type = #{issue_type}
                </if>
                <if test="issueTypeList != null and issueTypeList.size() > 0">
                    and super_issue_type in
                    <foreach collection="issueTypeList" item="item" open="(" separator="," close=")">
                        #{item}
                    </foreach>
                </if>
                <if test="source != null and source != ''">
                    and source = #{source}
                </if>
                <if test="private != null and private != ''">
                    and private = #{private}
                </if>
                <if test="internalList != null and internalList.size() > 0">
                    and internal in
                    <foreach collection="internalList" item="item" open="(" separator="," close=")">
                        #{item}
                    </foreach>
                </if>
            </where>
            <if test="group_dim == 'sub_community'">
                group by sub_community
                <if test="issue_type != null and issue_type != ''">
                    ,super_issue_type
                </if>
            </if>
            <if test="group_dim == 'repo'">
                group by namespace, repo_path, repo_url
                <if test="issue_type != null and issue_type != ''">
                    ,super_issue_type
                </if>
            </if>
        ),
        contribute_data AS (
            SELECT
                <if test="group_dim == 'sub_community'">
                    sub_community,   
                </if>     
                <if test="group_dim == 'repo'">
                    namespace, repo_path, repo_url,
                </if>       
                <if test="issue_type != null and issue_type != ''">
                    super_issue_type as issue_type,
                </if>
                COALESCE(sum(issue_incre), 0) as count, COALESCE(sum(open_issue_incre), 0) as open_count,
                COALESCE(sum(unresponse_open_issue_incre), 0) as unresponse_open_count, 
                COALESCE(sum(closed_issue_incre), 0) as closed_count, 
                COALESCE(sum(open_issue_incre), 0) + COALESCE(sum(progressing_issue_incre), 0) as unclosed_count,
                ROUND(
                    CASE
                        WHEN sum(issue_incre) = 0 THEN 0
                        ELSE (sum(issue_incre) - sum(open_issue_incre) - sum(progressing_issue_incre))::NUMERIC / sum(issue_incre)
                    END::NUMERIC , 4
                ) as closed_ratio,
                ROUND(
                    CASE
                        WHEN sum(issue_incre) = 0 THEN 0
                        ELSE sum(first_reply_time)::NUMERIC / sum(issue_incre) / 86400
                    END::NUMERIC , 2
                ) as avg_first_reply_time,
                ROUND(
                    CASE
                        WHEN sum(issue_incre) = 0 THEN 0
                        ELSE sum(closed_time)::NUMERIC / sum(issue_incre) / 86400
                    END::NUMERIC , 2
                ) as avg_closed_time,
                ROUND(
                    CASE
                        WHEN sum(issue_incre) = 0 THEN 0
                        ELSE sum(overdue_first_reply_time)::NUMERIC / sum(issue_incre) / 86400
                    END::NUMERIC , 2
                ) as avg_overdue_first_reply_time,
                ROUND(
                    CASE
                        WHEN sum(issue_incre) = 0 THEN 0
                        ELSE sum(overdue_closed_time)::NUMERIC / sum(issue_incre) / 86400
                    END::NUMERIC , 2
                ) as avg_overdue_closed_time,
                ROUND(
                    CASE
                        WHEN sum(issue_incre) = 0 THEN 0
                        ELSE sum(eight_hour_response_issue_incre)::NUMERIC / sum(issue_incre)
                    END::NUMERIC , 2
                ) as eight_hour_response_ratio,
                ROUND(
                    CASE
                        WHEN sum(issue_incre) = 0 THEN 0
                        ELSE sum(one_day_response_issue_incre)::NUMERIC / sum(issue_incre)
                    END::NUMERIC , 2
                ) as one_day_response_ratio,
                ROUND(
                    CASE
                        WHEN sum(issue_incre) = 0 THEN 0
                        ELSE sum(five_day_closed_issue_incre)::NUMERIC / sum(issue_incre)
                    END::NUMERIC , 2
                ) as five_day_closed_ratio,
                ROUND(
                    CASE
                        WHEN sum(issue_incre) = 0 THEN 0
                        ELSE sum(seven_day_closed_issue_incre)::NUMERIC / sum(issue_incre)
                    END::NUMERIC , 2
                ) as seven_day_closed_ratio,
                ROUND(
                    CASE
                        WHEN sum(issue_incre) = 0 THEN 0
                        ELSE sum(comment_num)::NUMERIC / sum(issue_incre)
                    END::NUMERIC , 2
                ) as comment_num
            FROM ${contributeTable}
            <where>
                <if test="start != null ">
                    and date >= #{start}
                </if>
                <if test="end != null ">
                    and date <= #{end}
                </if>
                <if test="namespace != null and namespace != ''">
                    and namespace LIKE CONCAT('%', #{namespace}, '%')
                </if>
                <if test="repo_path != null and repo_path != ''">
                    and repo_path LIKE CONCAT('%', #{repo_path}, '%')
                </if>
                <if test="issue_type != null and issue_type != ''">
                    and super_issue_type = #{issue_type}
                </if>
                <if test="issueTypeList != null and issueTypeList.size() > 0">
                    and super_issue_type in
                    <foreach collection="issueTypeList" item="item" open="(" separator="," close=")">
                        #{item}
                    </foreach>
                </if>
                <if test="source != null and source != ''">
                    and source = #{source}
                </if>
                <if test="private != null and private != ''">
                    and private = #{private}
                </if>
                <if test="internalList != null and internalList.size() > 0">
                    and internal in
                    <foreach collection="internalList" item="item" open="(" separator="," close=")">
                        #{item}
                    </foreach>
                </if>
            </where>
            <if test="group_dim == 'sub_community'">
                group by sub_community
                <if test="issue_type != null and issue_type != ''">
                    ,super_issue_type
                </if>
            </if>
            <if test="group_dim == 'repo'">
                group by namespace, repo_path, repo_url
                <if test="issue_type != null and issue_type != ''">
                    ,super_issue_type
                </if>
            </if>
        ),
        group_data as (
            select
                <if test="group_dim == 'sub_community'">
                    d.sub_community,   
                </if>     
                <if test="group_dim == 'repo'">
                    d.namespace, d.repo_path, d.repo_url,
                </if>                
                <if test="(issue_type == null or issue_type == '') and (issueTypeList == null or issueTypeList.size() == 0)">
                    'All' as issue_type,
                </if> 
                <if test="issue_type != null and issue_type != ''">
                    #{issue_type} as issue_type,
                </if>
                <if test="issueTypeList != null and issueTypeList.size() > 0">
                    #{issueTypes} as issue_type,
                </if>
                COALESCE(count, 0) as count, COALESCE(open_count, 0) as open_count,
                COALESCE(week_new_count, 0) as week_new_count,
                COALESCE(unresponse_open_count, 0) as unresponse_open_count, 
                COALESCE(closed_count, 0) as closed_count, 
                COALESCE(unclosed_count, 0) as unclosed_count, 
                COALESCE(closed_ratio, 0) as closed_ratio, 
                COALESCE(avg_first_reply_time, 0) as avg_first_reply_time, 
                COALESCE(avg_closed_time, 0) as avg_closed_time, 
                COALESCE(avg_overdue_first_reply_time, 0) as avg_overdue_first_reply_time, 
                COALESCE(avg_overdue_closed_time, 0) as avg_overdue_closed_time,
                COALESCE(one_day_response_ratio, 0) as one_day_response_ratio, 
                COALESCE(eight_hour_response_ratio, 0) as eight_hour_response_ratio, 
                COALESCE(five_day_closed_ratio, 0) as five_day_closed_ratio, 
                COALESCE(seven_day_closed_ratio, 0) as seven_day_closed_ratio, 
                COALESCE(comment_num, 0) as comment_num
            FROM dim d
            LEFT JOIN contribute_data c 
            <if test="group_dim == 'sub_community'">
                ON d.sub_community = c.sub_community
            </if>     
            <if test="group_dim == 'repo'">
                ON d.namespace = c.namespace and d.repo_path = c.repo_path
            </if>
            LEFT JOIN last_week_data lwd
            <if test="group_dim == 'sub_community'">
                ON d.sub_community = lwd.sub_community
                ORDER BY d.sub_community
            </if>     
            <if test="group_dim == 'repo'">
                ON d.namespace = lwd.namespace and d.repo_path = lwd.repo_path
                ORDER BY d.repo_path
            </if>
        )
        SELECT 
            *, 
            (select count(1) from group_data) as total_count, 
            CEIL((select count(1) from group_data)::numeric/#{page_size}) as total_page
        FROM 
            group_data
        <if test="order_by != null and order_by != ''">
            ORDER BY ${order_by}
        </if>
        LIMIT #{page_size} OFFSET #{offset}
        """;
}
var query_data = db.select(sql);
var total_count = query_data.size() > 0 ? query_data[0].get("total_count") : 0;
var total_page = query_data.size() > 0 ? query_data[0].get("total_page") : 0;
query_data.forEach(item -> {
    item.remove("total_count");
    item.remove("total_page");
    return item;
})
HashMap result = new HashMap();
result.put("list", query_data);
result.put("total_count", total_count);
result.put("total_page", total_page);
return result