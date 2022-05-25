{{- define "zeppelin.container.zeppelin" -}}
name: {{ .Chart.Name }}
securityContext:
    {{- toYaml .Values.securityContext | nindent 2 }}
image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
imagePullPolicy: {{ .Values.image.pullPolicy }}
ports:
-   name: http
    containerPort: {{ .Values.service.port }}
    protocol: TCP
-   name: rpc
    containerPort: {{ .Values.service.rpcPort }}
    protocol: TCP
{{- if eq .Values.zeppelin.interpreter.mode "embedded" }}
-   name: spark-ui
    containerPort: {{ .Values.spark.driver.uiPort }}
    protocol: TCP
{{- end }}
livenessProbe:
    httpGet:
        path: /
        port: http
    initialDelaySeconds: 30
    timeoutSeconds: 1
readinessProbe:
    httpGet:
        path: /
        port: http
    initialDelaySeconds: 30
    timeoutSeconds: 1
resources:
    {{- toYaml .Values.resources | nindent 2 }}
workingDir: /opt/zeppelin
env:
-   name: ZEPPELIN_WAR_TEMPDIR
    value: webapps/tmp_dir
-   name: ZEPPELIN_MEM
    value:  {{ .Values.zeppelin.server.jvmMemOptions }}
-   name: POD_UID
    valueFrom:
        fieldRef:
            apiVersion: v1
            fieldPath: metadata.uid
-   name: POD_NAME
    valueFrom:
        fieldRef:
            apiVersion: v1
            fieldPath: metadata.name
-   name: SERVICE_DOMAIN
    value: {{ .Values.zeppelin.serviceDomain }}
{{- if eq .Values.zeppelin.interpreter.mode "embedded" }}
-   name: SPARK_HOME
    value: /spark
-   name: SPARK_LOCAL_HOSTNAME
    valueFrom:
        fieldRef:
            apiVersion: v1
            fieldPath: status.podIP
-   name: ZEPPELIN_RUN_MODE
    value: local
{{- end }}
{{- with .Values.extraEnvVars }}
{{- toYaml . | nindent 0 }}
{{- end }}
volumeMounts:
-   name: zep-tmp
    mountPath: /tmp
-   name: zep-conf
    mountPath: /opt/zeppelin/conf
-   name: zep-webapps
    mountPath: /opt/zeppelin/webapps
-   name: zep-notebooks
    mountPath: /opt/zeppelin/notebook
-   name: zep-logs
    mountPath: /opt/zeppelin/logs
-   name: etc-hack
    mountPath: /etc/passwd
    subPath: passwd
{{- if eq .Values.zeppelin.interpreter.mode "embedded" }}
-   name: spark-home
    mountPath: /spark
-   name: spark-hive-warehouse
    mountPath: /opt/zeppelin/hive-warehouse
-   name: spark-derby-home
    mountPath: /opt/zeppelin/derby
-   name: zep-repo
    mountPath: /opt/zeppelin/local-repo
-   name: zep-ivy
    mountPath: /opt/zeppelin/.ivy2
{{- end }}
{{- with .Values.extraVolumeMounts }}
{{ . | toYaml }}
{{- end }}
{{- end }}