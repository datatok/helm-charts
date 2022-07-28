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
            "defaultValue": {{$v | quote}},
            "type": "string",
            "description" : "From spark.confg"
        },
        {{- end }}
        {{- range $k, $v := .Values.spark.interpreterProperties }}
        "{{ $k }}": {
            "propertyName": "{{$k}}",
            "defaultValue": {{$v.value | quote}},
            "type": "{{$v.type}}",
            "description" : "{{$v.description}} (from spark.interpreterProperties)"
        },
        {{- end }}
        "" : {
          "propertyName": "",
          "defaultValue": "",
          "type": "string",
          "description" : "dummy"
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