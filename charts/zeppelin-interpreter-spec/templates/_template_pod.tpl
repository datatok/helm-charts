{{- define "zeppelin-interpreter-template.pod" }}
kind: Pod
apiVersion: v1
metadata:
  namespace: {{`{{`}}zeppelin.k8s.namespace{{`}}`}}
  name: {{`{{`}}zeppelin.k8s.interpreter.pod.name{{`}}`}}
  labels:
    app: {{`{{`}}zeppelin.k8s.interpreter.pod.name{{`}}`}}
    interpreterGroupId: {{`{{`}}zeppelin.k8s.interpreter.group.id{{`}}`}}
    interpreterSettingName: {{`{{`}}zeppelin.k8s.interpreter.setting.name{{`}}`}}
    user: {{`{{`}} zeppelin.k8s.interpreter.user {{`}}`}}
    {{- include "zeppelin-interpreter-template.selectorLabels" . | nindent 4 }}
    {{- with .Values.podLabels }}
      {{- toYaml . | nindent 4 }}
    {{- end }}
    {{- with .Values.podAnnotations }}
    annotations:
      {{- toYaml . | nindent 6 }}
    {{- end }}
  {% if zeppelin.k8s.server.uid is defined %}
  ownerReferences:
  - apiVersion: v1
    controller: false
    blockOwnerDeletion: false
    kind: Pod
    name: {{`{{`}}zeppelin.k8s.server.pod.name{{`}}`}}
    uid: {{`{{`}}zeppelin.k8s.server.uid{{`}}`}}
  {% endif %}
spec:
  restartPolicy: Never
  {% if zeppelin.k8s.interpreter.imagePullSecrets is defined %}
  imagePullSecrets:
  {% for secret in zeppelin.k8s.interpreter.imagePullSecrets.split(',') %}
  - name: {{`{{`}}secret{{`}}`}}
  {% endfor %}
  {% endif %}
  {{- if or .Values.serviceAccount.create .Values.serviceAccount.name }}
  serviceAccountName: {{ include "zeppelin-interpreter-template.serviceAccountName" . }}
  {{- else }}
  serviceAccountName: {{`{{`}} zeppelin.k8s.interpreter.serviceAccount {{`}}`}}
  {{- end }}
  {{- with .Values.podSecurityContext }}
  securityContext:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {% if zeppelin.k8s.interpreter.group.name == "spark" %}
  automountServiceAccountToken: true
  {% else %}
  automountServiceAccountToken: false
  {% endif %}
  restartPolicy: Never
  terminationGracePeriodSeconds: 30
  containers:
  - name: {{`{{`}}zeppelin.k8s.interpreter.container.name{{`}}`}}
    securityContext:
        {{- toYaml .Values.securityContext | nindent 12 }}
    image: {{`{{`}}zeppelin.k8s.interpreter.container.image{{`}}`}}
    imagePullPolicy: {{ .Values.image.pullPolicy }}
    workingDir: /opt/zeppelin/work
    args:
    - "$(ZEPPELIN_HOME)/bin/interpreter.sh"
    - "-d"
    - "$(ZEPPELIN_HOME)/interpreter/{{`{{`}}zeppelin.k8s.interpreter.group.name{{`}}`}}"
    - "-r"
    - "{{`{{`}}zeppelin.k8s.interpreter.rpc.portRange{{`}}`}}"
    - "-c"
    - "{{`{{`}}zeppelin.k8s.server.rpc.service{{`}}`}}"
    - "-p"
    - "{{`{{`}}zeppelin.k8s.server.rpc.portRange{{`}}`}}"
    - "-i"
    - "{{`{{`}}zeppelin.k8s.interpreter.group.id{{`}}`}}"
    - "-l"
    - "{{`{{`}}zeppelin.k8s.interpreter.localRepo{{`}}`}}/{{`{{`}}zeppelin.k8s.interpreter.setting.name{{`}}`}}"
    - "-g"
    - "{{`{{`}}zeppelin.k8s.interpreter.setting.name{{`}}`}}"
    env:
    - name: SPARK_PRINT_LAUNCH_COMMAND
      value: 'true'
    - name: ZEPPELIN_RUN_MODE
      value: k8s
    - name: ZEPPELIN_K8S_SPARK_CONTAINER_IMAGE
      value: "{{ .Values.sparkWorkerImage }}"
    {% for key, value in zeppelin.k8s.envs.items() %}
    - name: {{`{{`}}key{{`}}`}}
      value: {{`{{`}}value{{`}}`}}
    {% endfor %}
    - name: SPARK_HOME
      value: /opt/spark
    {{- with .Values.extraEnvVars }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
    {% if zeppelin.k8s.interpreter.cores is defined and zeppelin.k8s.interpreter.memory is defined %}
    resources:
      requests:
        memory: "{{`{{`}}zeppelin.k8s.interpreter.memory{{`}}`}}"
        cpu: "{{`{{`}}zeppelin.k8s.interpreter.cores{{`}}`}}"
      limits:
        memory: "{{`{{`}}zeppelin.k8s.interpreter.memory{{`}}`}}"
        cpu: "{{`{{`}}zeppelin.k8s.interpreter.cores{{`}}`}}"
        {% if zeppelin.k8s.interpreter.gpu.type is defined and zeppelin.k8s.interpreter.gpu.nums is defined %}
        {{`{{`}}zeppelin.k8s.interpreter.gpu.type{{`}}`}}: "{{`{{`}}zeppelin.k8s.interpreter.gpu.nums{{`}}`}}"
        {% endif %}
    {% else %}
    {% if zeppelin.k8s.interpreter.gpu.type is defined and zeppelin.k8s.interpreter.gpu.nums is defined %}
    resources:
      limits:  
        {{`{{`}}zeppelin.k8s.interpreter.gpu.type{{`}}`}}: "{{`{{`}}zeppelin.k8s.interpreter.gpu.nums{{`}}`}}"
    {% endif %}
    {% endif %}
    {% if zeppelin.k8s.interpreter.group.name == "spark" %}
    volumeMounts:
    - name: spark-home
      mountPath: /opt/spark/bin
      subPath: bin
      readOnly: true
    - name: spark-home
      mountPath: /opt/spark/jars
      subPath: jars
      readOnly: true
    - name: spark-home
      mountPath: /opt/spark/sbin
      subPath: sbin
      readOnly: true
    {{- if .Values.sparkConfConfigMap }}
    - name: spark-conf
      mountPath: /opt/spark/conf
    {{- end }}
    - name: spark-ivy
      mountPath: /opt/spark/.ivy
    - name: zeppelin-work
      mountPath: /opt/zeppelin/work
    - name: tmp
      mountPath: /tmp
    {{- if .Values.sparkExecutorPodTemplateConfigMap }}
    - name: spark-executor-pod-template
      mountPath: /opt/spark/k8s/executor-pod-template
    {{- end }}
    {{- with .Values.extraVolumeMounts }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
    ports:
    - name: http
      containerPort: 8080
      protocol: TCP
    - name: spark-driver
      containerPort: 4040
      protocol: TCP
  {% endif %}
  volumes:
  - name: spark-home
    persistentVolumeClaim:
      claimName: {{ .Values.sparkHomeVolumeClaim }}
  {{- with .Values.sparkConfConfigMap }}
  - name: spark-conf
    configMap:
       name: {{ . }}
  {{- end }}
  - name: spark-ivy
    {{- .Values.volumeSparkIvy | nindent 4 }}
  - name: zeppelin-work
    {{- .Values.volumeZeppelinWork | nindent 4 }}
  - name: tmp
    {{- .Values.volumeTmp | nindent 4 }}
  {{- if .Values.sparkExecutorPodTemplateConfigMap }}
  - name: spark-executor-pod-template
    configMap:
      name: {{ .Values.sparkExecutorPodTemplateConfigMap }}
  {{- end }}
  {{- with .Values.extraVolumes }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
  {% endif %}
  {{- with .Values.nodeSelector }}
  nodeSelector:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with .Values.affinity }}
  affinity:
    {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- with .Values.tolerations }}
  tolerations:
    {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end }}