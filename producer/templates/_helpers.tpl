{{- define "producer.name" -}}
{{- if .Chart -}}
{{- if .Chart.Name -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
"producer"
{{- end -}}
{{- else -}}
"producer"
{{- end -}}
{{- end }}

{{- define "producer.fullname" -}}
{{- if .Chart -}}
{{- include "producer.name" . }}-{{ .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else -}}
"producer-fullname"
{{- end -}}
{{- end }}

{{- define "producer.chart" -}}
{{- if and .Chart .Chart.Name .Chart.Version -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | trunc 63 | trimSuffix "-" -}}
{{- else -}}
"producer-chart"
{{- end -}}
{{- end }}

{{- define "producer.labels" -}}
{{- $labels := dict "app.kubernetes.io/name" (include "producer.name" .) "helm.sh/chart" (include "producer.chart" .) -}}
{{- if .Chart.AppVersion }}
{{- $_ := set $labels "app.kubernetes.io/version" .Chart.AppVersion -}}
{{- end -}}
{{- if .Chart.Version }}
{{- $_ := set $labels "helm.sh/chart" .Chart.Version -}}
{{- end -}}
{{- $labels | toYaml | nindent 4 -}}
{{- end }}