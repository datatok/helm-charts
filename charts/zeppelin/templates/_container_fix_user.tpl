{{- define "zeppelin.container.fix-user" }}
name: {{ .Chart.Name }}-fix-user
securityContext:
    {{- toYaml .Values.securityContext | nindent 12 }}
image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
imagePullPolicy: {{ .Values.image.pullPolicy }}
command:
- '/bin/sh'
- '-c'
- |+
    myuid=$(id -u)
    mygid=$(id -g)
    uidentry=$(getent passwd $myuid)

    cp /etc/passwd /opt/my-etc/passwd

    if [ -z "$uidentry" ] ; then
        if [ -w /opt/my-etc/passwd ] ; then
            echo "zeppelin:x:$myuid:$mygid:Zeppelin user:${PWD}:/bin/false" >> /opt/my-etc/passwd
        else
            echo "Container ENTRYPOINT failed to add passwd entry for zeppelin UID"
        fi
    fi
resources:
    requests:
        cpu: 10m
        memory: 32Mi
    limits:
        cpu: 50m
        memory: 64Mi
volumeMounts:
-   name: etc-hack
    mountPath: /opt/my-etc
{{- end }}