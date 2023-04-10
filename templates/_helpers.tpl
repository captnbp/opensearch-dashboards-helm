{{/* vim: set filetype=mustache: */}}

{{/*
Return the proper Opensearch Dashboards image name
*/}}
{{- define "opensearch-dashboards.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper image name (for the init container volume-permissions image)
*/}}
{{- define "opensearch-dashboards.volumePermissions.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.volumePermissions.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "opensearch-dashboards.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Return true if the deployment should include opensearch-dashboardss
*/}}
{{- define "opensearch-dashboards.importSavedObjects" -}}
{{- if or .Values.savedObjects.configmap .Values.savedObjects.urls }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Set Opensearch URL.
*/}}
{{- define "opensearch-dashboards.opensearch.url" -}}
{{- if .Values.opensearch.hosts -}}
{{- $totalHosts := len .Values.opensearch.hosts -}}
{{- $protocol := ternary "https" "http" .Values.opensearch.security.tls.enabled -}}
{{- range $i, $hostTemplate := .Values.opensearch.hosts -}}
{{- $host := tpl $hostTemplate $ }}
{{- printf "%s://%s:%s" $protocol $host (include "opensearch-dashboards.opensearch.port" $) -}}
{{- if (lt ( add1 $i ) $totalHosts ) }}{{- printf "," -}}{{- end }}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Set Opensearch Port.
*/}}
{{- define "opensearch-dashboards.opensearch.port" -}}
{{- .Values.opensearch.port -}}
{{- end -}}

{{/*
Set Opensearch PVC.
*/}}
{{- define "opensearch-dashboards.pvc" -}}
{{- .Values.persistence.existingClaim | default (include "common.names.fullname" .) -}}
{{- end -}}

{{/*
Get the saved objects configmap name.
*/}}
{{- define "opensearch-dashboards.savedObjectsCM" -}}
{{- printf "%s" (tpl .Values.savedObjects.configmap $) -}}
{{- end -}}

{{/*
Set Opensearch Port.
*/}}
{{- define "opensearch-dashboards.configurationCM" -}}
{{- .Values.configurationCM | default (printf "%s-conf" (include "common.names.fullname" .)) -}}
{{- end -}}

{{/*
Compile all warnings into a single message, and call fail.
*/}}
{{- define "opensearch-dashboards.validateValues" -}}
{{- $messages := list -}}
{{- $messages := append $messages (include "opensearch-dashboards.validateValues.noElastic" .) -}}
{{- $messages := append $messages (include "opensearch-dashboards.validateValues.configConflict" .) -}}
{{- $messages := append $messages (include "opensearch-dashboards.validateValues.extraVolumes" .) -}}
{{- $messages := append $messages (include "opensearch-dashboards.validateValues.tls" .) -}}
{{- $messages := append $messages (include "opensearch-dashboards.validateValues.opensearch.auth" .) -}}
{{- $messages := append $messages (include "opensearch-dashboards.validateValues.opensearch.tls" .) -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{-   printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/* Validate values of Opensearch Dashboards - must provide an ElasticSearch */}}
{{- define "opensearch-dashboards.validateValues.noElastic" -}}
{{- if and (not .Values.opensearch.hosts) (not .Values.opensearch.port) -}}
opensearch-dashboards: no-opensearch
    You did not specify an external Opensearch instance.
    Please set opensearch.hosts and opensearch.port
{{- else if and (not .Values.opensearch.hosts) .Values.opensearch.port }}
opensearch-dashboards: missing-os-settings-host
    You specified the external Opensearch port but not the host. Please
    set opensearch.hosts
{{- else if and .Values.opensearch.hosts (not .Values.opensearch.port) }}
opensearch-dashboards: missing-os-settings-port
    You specified the external Opensearch hosts but not the port. Please
    set opensearch.port
{{- end -}}
{{- end -}}

{{/* Validate values of Opensearch Dashboards - configuration conflict */}}
{{- define "opensearch-dashboards.validateValues.configConflict" -}}
{{- if and (.Values.extraConfiguration) (.Values.configurationCM) -}}
opensearch-dashboards: conflict-configuration
    You specified a ConfigMap with opensearch_dashboards.yml and a set of settings to be added
    to the default opensearch_dashboards.yml. Please only set either extraConfiguration or configurationCM
{{- end -}}
{{- end -}}

{{/* Validate values of Opensearch Dashboards - Incorrect extra volume settings */}}
{{- define "opensearch-dashboards.validateValues.extraVolumes" -}}
{{- if and (.Values.extraVolumes) (not .Values.extraVolumeMounts) -}}
opensearch-dashboards: missing-extra-volume-mounts
    You specified extra volumes but not mount points for them. Please set
    the extraVolumeMounts value
{{- end -}}
{{- end -}}

{{/* Validate values of Opensearch Dashboards - No certificates for Opensearch Dashboards server */}}
{{- define "opensearch-dashboards.validateValues.tls" -}}
{{- if and .Values.tls.enabled (not .Values.tls.existingSecret) (not .Values.tls.autoGenerated) -}}
opensearch-dashboards: tls.enabled
    In order to enable HTTPS for Opensearch Dashboards, you also need to provide an existing secret
    containing the TLS certificates (--set tls.existingSecret="my-secret") or enable
    auto-generated certificates (--set tls.autoGenerated="true").
{{- end -}}
{{- end -}}

{{/* Validate values of Opensearch Dashboards - No credentials for Opensearch auth */}}
{{- define "opensearch-dashboards.validateValues.opensearch.auth" -}}
{{- if and .Values.opensearch.security.auth.enabled (not .Values.opensearch.security.auth.dashboardsPassword) (not .Values.opensearch.security.auth.existingSecret) -}}
opensearch-dashboards: missing-opensearch-dashboards-credentials
    You enabled Opensearch authentication but you didn't provide the required credentials for
    Opensearch Dashboards to connect. Please provide them (--set opensearch.security.auth.opensearch-dashboardsPassword="XXXXX")
    or the name of an existing secret containing them (--set opensearch.security.auth.existingSecret="my-secret").
{{- end -}}
{{- end -}}

{{/* Validate values of Opensearch Dashboards - Opensearch HTTPS no trusted CA */}}
{{- define "opensearch-dashboards.validateValues.opensearch.tls" -}}
{{- if and .Values.opensearch.security.tls.enabled (ne "none" .Values.opensearch.security.tls.verificationMode) (not .Values.opensearch.security.tls.existingSecret) -}}
opensearch-dashboards: missing-opensearch-trusted-ca
    You configured communication with Opensearch REST API using HTTPS and
    verification enabled but no existing secret containing the Truststore or CA
    certificate was provided (--set opensearch.security.tls.existingSecret="my-secret").
{{- end -}}
{{- end -}}

{{/*
Check if there are rolling tags in the images
*/}}
{{- define "opensearch-dashboards.checkRollingTags" -}}
{{- include "common.warnings.rollingTag" .Values.image }}
{{- end -}}

{{/*
Return the secret containing Opensearch Dashboards TLS certificates
*/}}
{{- define "opensearch-dashboards.tlsSecretName" -}}
{{- $secretName := .Values.tls.existingSecret -}}
{{- if $secretName -}}
    {{- printf "%s" (tpl $secretName $) -}}
{{- else -}}
    {{- printf "%s-crt" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a TLS secret object should be created
*/}}
{{- define "opensearch-dashboards.createTlsSecret" -}}
{{- if and .Values.tls.enabled .Values.tls.autoGenerated (not .Values.tls.existingSecret) }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
basePath URL in use by the APIs.
*/}}
{{- define "opensearch-dashboards.basePath" -}}
{{- if  (.Values.configuration.server.rewriteBasePath) }}
{{- .Values.configuration.server.basePath -}}
{{- end -}}
{{- end -}}

{{/*
Return true if a Passwords secret object should be created
*/}}
{{- define "opensearch-dashboards.createSecret" -}}
{{- $dashboardsPassword := and .Values.opensearch.security.auth.enabled (not .Values.opensearch.security.auth.existingSecret) -}}
{{- $serverTlsPassword := and .Values.tls.enabled (or .Values.tls.keystorePassword .Values.tls.keyPassword) (not .Values.tls.passwordsSecret) -}}
{{- $opensearchTlsPassword := and .Values.opensearch.security.tls.enabled .Values.opensearch.security.tls.truststorePassword (not .Values.opensearch.security.tls.passwordsSecret) -}}
{{- if or $dashboardsPassword $serverTlsPassword $opensearchTlsPassword }}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the name of secret containing the Opensearch auth credentials
*/}}
{{- define "opensearch-dashboards.opensearch.auth.secretName" -}}
{{- if .Values.opensearch.security.auth.existingSecret -}}
  {{- printf "%s" .Values.opensearch.security.auth.existingSecret -}}
{{- else -}}
  {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the name of secret containing the Opensearch auth credentials
*/}}
{{- define "opensearch-dashboards.opensearch.tls.secretName" -}}
{{- if .Values.opensearch.security.tls.passwordsSecret -}}
  {{- printf "%s" .Values.opensearch.security.tls.passwordsSecret -}}
{{- else -}}
  {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Return the name of secret containing the Opensearch auth credentials
*/}}
{{- define "opensearch-dashboards.tls.secretName" -}}
{{- if .Values.tls.passwordsSecret -}}
  {{- printf "%s" .Values.tls.passwordsSecret -}}
{{- else -}}
  {{- printf "%s" (include "common.names.fullname" .) -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "opensearch-dashboards.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
