{{- define "zeppelin.container.config" }}
name: {{ .Chart.Name }}-config-init
securityContext:
    {{- toYaml .Values.securityContext | nindent 2 }}
image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
imagePullPolicy: {{ .Values.image.pullPolicy }}
command:
- '/bin/sh'
- '-c'
- >
    cp conf/* prepared_conf;
resources:
    requests:
        cpu: 10m
        memory: 32Mi
    limits:
        cpu: 50m
        memory: 64Mi
volumeMounts:
-   name: zep-conf
    mountPath: /opt/zeppelin/prepared_conf
-   name: config
    mountPath: /opt/zeppelin/conf/log4j.properties
    subPath: log4j.properties
-   name: site-config
    mountPath: /opt/zeppelin/conf/zeppelin-site.xml
    subPath: zeppelin-site.xml
{{- end }}