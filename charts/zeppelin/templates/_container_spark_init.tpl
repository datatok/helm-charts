{{- define "zeppelin.container.spark-init" }}
name: {{ .Chart.Name }}-spark-init
securityContext:
    {{- toYaml .Values.securityContext | nindent 2 }}
{{- with .Values.spark.homeArtifacts.image }}
image: "{{ .registry }}/{{ .repository }}:{{ .tag }}"
imagePullPolicy: {{ .pullPolicy }}
{{- end }}
command: ["sh", "-c", "cp -r {{ .Values.spark.homeArtifacts.copyDirectory }}/* /spark/"]
resources:
    requests:
        cpu: 10m
        memory: 32Mi
    limits:
        cpu: 50m
        memory: 64Mi
volumeMounts:
-   name: spark-home
    mountPath: /spark
{{- end }}