{{- define "zeppelin.int.spark" }}
[
  {
    "group": "spark",
    "name": "spark",
    "className": "org.apache.zeppelin.spark.SparkInterpreter",
    "defaultInterpreter": true,
    "properties": {
        {{- range $k, $v := .Values.spark.config }}
        "{{ $k }}": {
            "propertyName": "{{$k}}",
            "defaultValue": "{{$v}}",
            "type": "string"
        },
        {{- end }}
        "zeppelin.spark.useHiveContext": {
          "envName": null,
          "propertyName": "zeppelin.spark.useHiveContext",
          "defaultValue": {{- default .Values.spark.interpreterProperties.useHiveContext true }},
          "description": "Use HiveContext instead of SQLContext if it is true. Enable hive for SparkSession.",
          "type": "checkbox"
        },
  
        "zeppelin.spark.run.asLoginUser": {
          "envName": null,
          "propertyName": "zeppelin.spark.run.asLoginUser",
          "defaultValue": true,
          "description": "Whether run spark job as the zeppelin login user, it is only applied when running spark job in hadoop yarn cluster and shiro is enabled",
          "type": "checkbox"
        },
    
        "zeppelin.spark.printREPLOutput": {
          "envName": null,
          "propertyName": "zeppelin.spark.printREPLOutput",
          "defaultValue": true,
          "description": "Print scala REPL output",
          "type": "checkbox"
        },
        "zeppelin.spark.maxResult": {
          "envName": null,
          "propertyName": "zeppelin.spark.maxResult",
          "defaultValue": "1000",
          "description": "Max number of Spark SQL result to display.",
          "type": "number"
        },
  
        "zeppelin.spark.enableSupportedVersionCheck": {
          "envName": null,
          "propertyName": "zeppelin.spark.enableSupportedVersionCheck",
          "defaultValue": true,
          "description": "Whether checking supported spark version. Developer only setting, not for production use",
          "type": "checkbox"
        },
        "zeppelin.spark.uiWebUrl": {
          "envName": null,
          "propertyName": "zeppelin.spark.uiWebUrl",
          "defaultValue": "",
          "description": "Override Spark UI default URL. In Kubernetes mode, value can be Jinja template string with 3 template variables 'PORT', 'SERVICE_NAME' and 'SERVICE_DOMAIN'. ",
          "type": "string"
        },
        "zeppelin.spark.ui.hidden": {
          "envName": null,
          "propertyName": "zeppelin.spark.ui.hidden",
          "defaultValue": false,
          "description": "Whether hide spark ui in zeppelin ui",
          "type": "checkbox"
        },
        "spark.webui.yarn.useProxy": {
          "envName": null,
          "propertyName": "",
          "defaultValue": false,
          "description": "whether use yarn proxy url as spark weburl, e.g. http://localhost:8088/proxy/application_1583396598068_0004",
          "type": "checkbox"
        },
        "zeppelin.spark.scala.color": {
          "envName": null,
          "propertyName": "zeppelin.spark.scala.color",
          "defaultValue": true,
          "description": "Whether enable color output of spark scala interpreter",
          "type": "checkbox"
        },
        "zeppelin.spark.deprecatedMsg.show": {
          "envName": null,
          "propertyName": "zeppelin.spark.deprecatedMsg.show",
          "defaultValue": true,
          "description": "Whether show the spark deprecated message, spark 2.2 and before are deprecated. Zeppelin will display warning message by default",
          "type": "checkbox"
        }
    }
  },
  {
    "group": "spark",
    "name": "sql",
    "className": "org.apache.zeppelin.spark.SparkSqlInterpreter",
    "properties": {
      "zeppelin.spark.concurrentSQL": {
        "envName": null,
        "propertyName": "zeppelin.spark.concurrentSQL",
        "defaultValue": true,
        "description": "Execute multiple SQL concurrently if set true.",
        "type": "checkbox"
      },
      "zeppelin.spark.concurrentSQL.max": {
        "envName": null,
        "propertyName": "zeppelin.spark.concurrentSQL.max",
        "defaultValue": "10",
        "description": "Max number of SQL concurrently executed",
        "type": "number"
      },
      "zeppelin.spark.sql.stacktrace": {
        "envName": null,
        "propertyName": "zeppelin.spark.sql.stacktrace",
        "defaultValue": true,
        "description": "Show full exception stacktrace for SQL queries if set to true.",
        "type": "checkbox"
      },
      "zeppelin.spark.sql.interpolation": {
        "envName": null,
        "propertyName": "zeppelin.spark.sql.interpolation",
        "defaultValue": false,
        "description": "Enable ZeppelinContext variable interpolation into spark sql",
        "type": "checkbox"
      }
    },
    "editor": {
      "language": "sql",
      "editOnDblClick": false,
      "completionKey": "TAB",
      "completionSupport": true
    }
  },
  {
    "group": "spark",
    "name": "pyspark",
    "className": "org.apache.zeppelin.spark.PySparkInterpreter",
    "properties": {
      "PYSPARK_PYTHON": {
        "envName": "PYSPARK_PYTHON",
        "propertyName": "PYSPARK_PYTHON",
        "defaultValue": "python",
        "description": "Python binary executable to use for PySpark in both driver and workers (default is python2.7 if available, otherwise python). Property `spark.pyspark.python` take precedence if it is set",
        "type": "string"
      },
      "PYSPARK_DRIVER_PYTHON": {
        "envName": "PYSPARK_DRIVER_PYTHON",
        "propertyName": "PYSPARK_DRIVER_PYTHON",
        "defaultValue": "python",
        "description": "Python binary executable to use for PySpark in driver only (default is `PYSPARK_PYTHON`). Property `spark.pyspark.driver.python` take precedence if it is set",
        "type": "string"
      },
      "zeppelin.pyspark.useIPython": {
        "envName": null,
        "propertyName": "zeppelin.pyspark.useIPython",
        "defaultValue": true,
        "description": "Whether use IPython when it is available",
        "type": "checkbox"
      }
    },
    "editor": {
      "language": "python",
      "editOnDblClick": false,
      "completionKey": "TAB",
      "completionSupport": true
    }
  },
  {
    "group": "spark",
    "name": "ipyspark",
    "className": "org.apache.zeppelin.spark.IPySparkInterpreter",
    "properties": {},
    "editor": {
      "language": "python",
      "editOnDblClick": false,
      "completionSupport": true,
      "completionKey": "TAB"
    }
  }
]
{{- end }}