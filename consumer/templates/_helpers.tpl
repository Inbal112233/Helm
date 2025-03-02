{{- define "consumer.name" -}}
{{- if .Chart -}}
{{- if .Chart.Name -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
"consumer"
{{- end -}}
{{- else -}}
"my-application"
{{- end -}}
{{- end }}

{{- define "consumer.fullname" -}}
{{- if .Chart -}}
{{- include "consumer.name" . }}-{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else -}}
"consumer-fullname"
{{- end -}}
{{- end }}

{{- define "consumer.chart" -}}
{{- if and .Chart .Chart.Name .Chart.Version -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | trunc 63 | trimSuffix "-" -}}
{{- else -}}
"consumer-chart"
{{- end -}}
{{- end }}

{{- define "consumer.labels" -}}
{{- $labels := dict "app.kubernetes.io/name" (include "consumer.name" .) "helm.sh/chart" (include "consumer.chart" .) -}}
{{- if .Chart.AppVersion }}
{{- $_ := set $labels "app.kubernetes.io/version" .Chart.AppVersion -}}
{{- end -}}
{{- if .Chart.Version }}
{{- $_ := set $labels "helm.sh/chart" .Chart.Version -}}
{{- end -}}
{{- $labels | toYaml | nindent 4 -}}
{{- end }}