{{- define "zeppelin-spark-artifacts.pod" }}
metadata:
  name: {{ include "zeppelin-spark-artifacts.fullname" . }}
  labels:
    {{- include "zeppelin-spark-artifacts.labels" . | nindent 4 }}
    {{- with .Values.podLabels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  restartPolicy: Never
  {{- with .Values.imagePullSecrets }}
  imagePullSecrets:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  containers:
  - name: spark
    command:
    - sh
    args:
    - -c
    - cp -r {{ .Values.sourcePath }}/* /var/buffer/
    image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
    imagePullPolicy: {{ .Values.image.pullPolicy }}
    resources:
      limits:
        cpu: 100m
        memory: 64Mi
      requests:
        cpu: 10m
        memory: 32Mi
    securityContext:
      allowPrivilegeEscalation: false
      capabilities:
        drop:
        - ALL
      readOnlyRootFilesystem: true
      runAsNonRoot: true
      runAsUser: 1000
    volumeMounts:
    - mountPath: /var/buffer
      name: buffer
  dnsPolicy: ClusterFirst
  securityContext:
    fsGroup: 1000
    runAsUser: 1000
  volumes:
  - name: buffer
    persistentVolumeClaim:
      claimName: {{ include "zeppelin-spark-artifacts.fullname" . }}-buffer
{{ end }}