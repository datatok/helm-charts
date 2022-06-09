{{- define "spark-spec.pod" }}
apiVersion: apps/v1
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
  securityContext:
    {{- toYaml .Values.podSecurityContext | nindent 4 }}
  containers:
    - name: spark
      workingDir: /opt/spark/work
      securityContext:
        {{- toYaml .Values.securityContext | nindent 8 }}
      imagePullPolicy: {{ .Values.image.pullPolicy }}
      ports:
        - name: http
          containerPort: 8081
          protocol: TCP
      livenessProbe:
        httpGet:
          path: /
          port: http
      readinessProbe:
        httpGet:
          path: /
          port: http
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