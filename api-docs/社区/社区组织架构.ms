{
  "properties" : { },
  "id" : "49b58106da5c4c068318673c0ef72407",
  "script" : null,
  "groupId" : "10e2710a382e42ef81f33c984351995e",
  "name" : "社区组织架构",
  "createTime" : null,
  "updateTime" : 1775736582676,
  "lock" : null,
  "createBy" : "admin",
  "updateBy" : "admin",
  "path" : "/org/type",
  "method" : "GET",
  "parameters" : [ {
    "name" : "community",
    "value" : "opengauss",
    "description" : null,
    "required" : true,
    "dataType" : "String",
    "type" : null,
    "defaultValue" : null,
    "validateType" : "pattern",
    "error" : null,
    "expression" : "^[a-zA-Z]{1,32}$",
    "children" : null
  } ],
  "options" : [ ],
  "requestBody" : "",
  "headers" : [ ],
  "paths" : [ ],
  "responseBody" : "{\n    \"code\": 1,\n    \"message\": \"success\",\n    \"data\": {\n        \"sigs\": [\"AI\", \"Blockchain\", \"Certification\", \"CloudNative\", \"CM\", \"Connectors\", \"DBCopilot\", \"DCF\", \"Docs\", \"Embedded\", \"GIS\", \"Graph\", \"Infra\", \"In-place-Update\", \"IoT\", \"KnowledgeGraph\", \"oGRAC\", \"OM\", \"OPS\", \"Plugin\", \"QA\", \"ReleaseManagement\", \"RISC-V\", \"Security\", \"SecurityTechnology\", \"SQLEngine\", \"StorageEngine\", \"Tools\"],\n        \"orgs\": []\n    },\n    \"timestamp\": 1775727097260,\n    \"executeTime\": 12\n}",
  "description" : "获取社区所有组织类型列表，包括社区组织架构下的组织列表、SIG组列表",
  "requestBodyDefinition" : null,
  "responseBodyDefinition" : null
}
================================
var sig_user_table = `fact_${community}_sig_user`
var org_member_table = `fact_${community}_organization_member`

var check_sig_table = db.select("""SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = #{sig_user_table})""")
var check_org_table = db.select("""SELECT EXISTS (SELECT FROM information_schema.tables WHERE table_name = #{org_member_table})""")

var sig_table_exists = check_sig_table[0].exists
var org_table_exists = check_org_table[0].exists

var sigs = []
var orgs = []

if (sig_table_exists) {
    var sig_sql = """
    SELECT array_agg(DISTINCT "sig_name") as "sigs"
    FROM ${sig_user_table}
    WHERE "sig_name" IS NOT NULL
    """
    var sig_result = db.select(sig_sql)
    if (sig_result.length > 0 && sig_result[0].sigs) {
        sigs = sig_result[0].sigs.getArray()
    }
}

if (org_table_exists) {
    var org_sql = """
    SELECT array_agg(DISTINCT "group_name") as "orgs"
    FROM ${org_member_table}
    WHERE "group_name" IS NOT NULL
    """
    var org_result = db.select(org_sql)
    if (org_result.length > 0 && org_result[0].orgs) {
        orgs = org_result[0].orgs.getArray()
    }
}

return { "sigs": sigs, "orgs": orgs }
