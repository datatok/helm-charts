{{- define "zeppelin-interpreter-template.service" -}}
kind: Service
apiVersion: v1
metadata:
  namespace: {{`{{`}}zeppelin.k8s.namespace{{`}}`}}
  name: {{`{{`}}zeppelin.k8s.interpreter.pod.name{{`}}`}}            # keep Service name the same to Pod name.
  labels:
    {{- include "zeppelin-interpreter-template.labels" . | nindent 4 }}
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
  clusterIP: None
  ports:
  - name: intp
    port: 12321
  {% if zeppelin.k8s.interpreter.group.name == "spark" %}
  - name: spark-driver
    port: 22321
  - name: spark-blockmanager
    port: 22322
  - name: spark-ui
    port: 4040
  {% endif %}
  selector:
    app: {{`{{`}}zeppelin.k8s.interpreter.pod.name{{`}}`}}
{{- end }}