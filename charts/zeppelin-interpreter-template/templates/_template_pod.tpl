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
        {{- include "zeppelin-interpreter-template.selectorLabels" . | nindent 8 }}
        {{- with .Values.podLabels }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
    {{- with .Values.podAnnotations }}
    annotations:
        {{- toYaml . | nindent 8 }}
    {{- end }}
    {% if zeppelin.k8s.server.uid is defined %}
    ownerReferences:
    -   apiVersion: v1
        controller: false
        blockOwnerDeletion: false
        kind: Pod
        name: {{`{{`}}zeppelin.k8s.server.pod.name{{`}}`}}
        uid: {{`{{`}}zeppelin.k8s.server.uid{{`}}`}}
    {% endif %}
spec:
    {{- with .Values.imagePullSecrets }}
    imagePullSecrets:
        {{- toYaml . | nindent 4 }}
    {{- end }}
    serviceAccountName: {{ include "zeppelin-interpreter-template.serviceAccountName" . }}
    securityContext:
        {{- toYaml .Values.podSecurityContext | nindent 4 }}
    {% if zeppelin.k8s.interpreter.group.name == "spark" %}
    automountServiceAccountToken: true
    {% else %}
    automountServiceAccountToken: false
    {% endif %}
    restartPolicy: Never
    terminationGracePeriodSeconds: 30
    containers:
    -   name: {{`{{`}}zeppelin.k8s.interpreter.container.name{{`}}`}}
        securityContext:
            {{- toYaml .Values.securityContext | nindent 12 }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
        imagePullPolicy: {{ .Values.image.pullPolicy }}
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
        -   name: SPARK_PRINT_LAUNCH_COMMAND
            value: 'true'
        -   name: ZEPPELIN_RUN_MODE
            value: k8s
        -   name: ZEPPELIN_K8S_SPARK_CONTAINER_IMAGE
            value: "registry.qwant.ninja/product/analytic/docker/spark:3.2.1-3"
    {% for key, value in zeppelin.k8s.envs.items() %}
        -   name: {{`{{`}}key{{`}}`}}
            value: {{`{{`}}value{{`}}`}}
    {% endfor %}
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
        -   name: spark-home
            mountPath: /spark
        -   mountPath: /tmp
            name: tmp
        {{- with .Values.extraVolumeMounts }}
        {{ . | toYaml }}
        {{- end }}
        ports:
        -   name: http
            containerPort: 8080
            protocol: TCP
        -   name: spark-driver
            containerPort: 4040
            protocol: TCP
    {% endif %}
    volumes:
    -   name: spark-home
        emptyDir: {}
    -   name: tmp
        emptyDir: {}
    {{- with .Values.extraVolumes }}
    {{ . | toYaml | nindent 6 }}
    {{- end }}
    {% endif %}
    {{- with .Values.nodeSelector }}
    nodeSelector:
      {{- toYaml . | nindent 6 }}
    {{- end }}
    {{- with .Values.affinity }}
    affinity:
      {{- toYaml . | nindent 6 }}
    {{- end }}
    {{- with .Values.tolerations }}
    tolerations:
      {{- toYaml . | nindent 6 }}
    {{- end }}
{{- end }}