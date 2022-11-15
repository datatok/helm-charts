{{/*
Expand the name of the chart.
*/}}
{{- define "spark-cluster.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "spark-cluster.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "spark-cluster.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "spark-cluster.labels" -}}
helm.sh/chart: {{ include "spark-cluster.chart" . }}
{{ include "spark-cluster.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spark-cluster.sparkLabels" -}}
spark.apache.org/cluster: {{ include "spark-cluster.fullname" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spark-cluster.sparkClientLabels" -}}
spark.apache.org/cluster-{{ include "spark-cluster.fullname" . }}: allow
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spark-cluster.selectorLabels" -}}
{{ include "spark-cluster.sparkClientLabels" . }}
app.kubernetes.io/name: {{ include "spark-cluster.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spark-cluster-master.labels" -}}
app.kubernetes.io/component: master
{{- end }}

{{/*
Selector labels
*/}}
{{- define "spark-cluster-worker.labels" -}}
app.kubernetes.io/component: worker
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "spark-cluster.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "spark-cluster.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
