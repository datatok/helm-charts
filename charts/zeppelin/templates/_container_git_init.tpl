{{- define "zeppelin.container.git-init" -}}
name: {{ .Chart.Name }}-git-init
securityContext:
    {{- toYaml .Values.securityContext | nindent 2 }}
image: "bitnami/git:2-debian-10"
imagePullPolicy: {{ .Values.image.pullPolicy }}
workingDir: /opt/zeppelin/notebook
command:
- '/bin/sh'
- '-c'
- |+
    if [ -d ".git" ]; then
        echo "/opt/zeppelin/notebook is not empty, skipping git init."
    else
        rm -rf *
        git clone ${REPO_URL} .
        git config pull.ff only
    fi
resources:
    requests:
        cpu: 10m
        memory: 32Mi
    limits:
        cpu: 50m
        memory: 64Mi
volumeMounts:
-   name: zep-notebooks
    mountPath: /opt/zeppelin/notebook
-   name: git-config
    mountPath: /opt/zeppelin/.gitconfig
    subPath: .gitconfig
env:
-   name: GIT_SSL_NO_VERIFY
    value: "true"
-   name: REPO_URL
    valueFrom:
        secretKeyRef:
            name: {{ .Values.notebookStorage.repositorySecret }}
            key: url
{{- end }}