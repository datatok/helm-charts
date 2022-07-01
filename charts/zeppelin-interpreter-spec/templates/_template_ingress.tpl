{{- define "zeppelin-interpreter-template.ingress" -}}
{% if zeppelin.k8s.interpreter.group.name == "spark" %}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  namespace: {{`{{`}}zeppelin.k8s.namespace{{`}}`}}
  name: {{`{{`}}zeppelin.k8s.interpreter.pod.name{{`}}`}}
  labels:
    {{- include "zeppelin-interpreter-template.labels" . | nindent 4 }}
  annotations:
    cert-manager.io/common-name: {{`{{`}}zeppelin.k8s.interpreter.pod.name{{`}}`}}{{ .Values.ingress.hostSuffix }}
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
  tls:
  - hosts:
      - {{`{{`}}zeppelin.k8s.interpreter.pod.name{{`}}`}}{{ .Values.ingress.hostSuffix }}
    secretName: {{`{{`}}zeppelin.k8s.interpreter.pod.name{{`}}`}}-ing-tls
  rules:
  - host: {{`{{`}}zeppelin.k8s.interpreter.pod.name{{`}}`}}{{ .Values.ingress.hostSuffix }}
    http:
      paths:
        - path: /
          pathType: ImplementationSpecific
          backend:
            service:
              name: {{`{{`}}zeppelin.k8s.interpreter.pod.name{{`}}`}}
              port:
                number: 4040
{% endif %}
{{- end }}