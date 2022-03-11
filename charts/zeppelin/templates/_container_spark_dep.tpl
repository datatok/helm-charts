{{- define "zeppelin.container.spark-dep" }}
- name: {{ .Chart.Name }}-spark-dependencies
securityContext:
    {{- toYaml .Values.securityContext | nindent 2 }}
{{- with .Values.spark.homeArtifacts.image }}
image: "{{ .registry }}/{{ .repository }}:{{ .tag }}"
imagePullPolicy: {{ .pullPolicy }}
{{- end }}
command:
- sh
- "-c"
- >+
  
resources:
    requests:
        cpu: 10m
        memory: 32Mi
    limits:
        cpu: 50m
        memory: 64Mi
- name: zep-repo
  mountPath: /opt/zeppelin/local-repo
- name: zep-ivy
  mountPath: /opt/zeppelin/.ivy2
{{- end }}