{{- define "spark-spec.pod" }}
apiVersion: v1
kind: Pod
metadata:
  {{- with .Values.podAnnotations }}
  annotations:
    {{- toYaml . | nindent 8 }}
  {{- end }}
  labels:
    {{- include "spark-spec.selectorLabels" . | nindent 4 }}
    {{- with .Values.podLabels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  {{- with .Values.imagePullSecrets }}
  imagePullSecrets:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.podSecurityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  containers:
    - name: spark
      workingDir: /opt/spark/work
      {{- with .Values.securityContext }}
      securityContext:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      imagePullPolicy: {{ .Values.image.pullPolicy }}
      env:
      - name: SPARK_HOME
        value: /opt/spark
      - name: SPARK_WORKER_WEBUI_PORT
        value: 8081
      {{- with .Values.extraEnvVars }}
      {{- toYaml . | nindent 4 }}
      {{- end }}
      volumeMounts:
      - name: spark-ivy
        mountPath: /opt/spark/.ivy
      - name: spark-work
        mountPath: /opt/spark/work
      - name: tmp
        mountPath: /tmp
      {{- with .Values.extraVolumeMounts }}
      {{- toYaml . | nindent 4 }}
      {{- end }}
  volumes:
  - name: spark-ivy
    {{- .Values.volumeSparkIvy | nindent 4 }}
  - name: spark-work
    {{- .Values.volumeSparkWork | nindent 4 }}
  - name: tmp
    {{- .Values.volumeTmp | nindent 4 }}
  {{- with .Values.extraVolumes }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with .Values.nodeSelector }}
  nodeSelector:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.affinity }}
  affinity:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.tolerations }}
  tolerations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}