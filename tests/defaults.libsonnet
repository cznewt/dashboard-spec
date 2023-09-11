local grafana = import 'grafonnet/grafana.libsonnet';

{
  alertmanagerDatasource::
    grafana.template.datasource.new(
      name='alertmanager',
      label='Alertmanager datasource',
      query='camptocamp-prometheus-alertmanager-datasource'
    ),
  alertmanagerSimpleTarget::
    grafana.target.alertmanager.new(
      datasource='$alertmanager',
      filters='alertname=~"(.+)"',
      active=true
    ),
  alertmanagerCriticalTarget::
    grafana.target.alertmanager.new(
      datasource='$alertmanager',
      filters='alertname=~"(.+)",severity="critical"',
      active=true
    ),
  alertmanagerWarningTarget::
    grafana.target.alertmanager.new(
      datasource='$alertmanager',
      filters='alertname=~"(.+)",severity="warning"',
      active=true
    ),
  alertmanagerInfoTarget::
    grafana.target.alertmanager.new(
      datasource='$alertmanager',
      filters='alertname=~"(.+)",severity="info"',
      active=true
    ),
  prometheusDatasource::
    grafana.template.datasource.new(
      name='prometheus',
      label='Prometheus datasource',
      query='prometheus'
    ),
  prometheusJobVariable::
    grafana.template.query.new(name='job', multi=true, includeAll=true)
    .setDatasource(uid='$prometheus',)
    .setQuery(query='label_values(node_load1{job=~".+"}, job)'),
  prometheusInstanceVariable::
    grafana.template.query.new(name='instance', multi=true, includeAll=true)
    .setDatasource(uid='$prometheus',)
    .setQuery(query='label_values(node_load1{job=~"$job"}, instance)'),
  prometheusSingleInstantTarget::
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='avg(node_load1{job=~"$job",instance=~"$instance"}) by (job)',
      legendFormat='{{instance}}',
      instant=true,
      range=false,
    ),
  prometheusSimpleTarget::
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='node_load1{job=~"$job",instance=~"$instance"}',
      legendFormat='{{instance}}'
    ),
  prometheusBucketTarget::
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='sum(increase(prometheus_http_request_duration_seconds_bucket[5m])) by (le)',
      legendFormat='{{le}}'
    ),
  prometheusTabularTarget::
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='sum by (job, instance) (node_load1{job=~"$job",instance=~"$instance"})',
      format='table',
      range=false,
      instant=true,
    ),
  prometheusSecondTabularTarget::
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='sum by (job, instance) (node_load15{job=~"$job",instance=~"$instance"})',
      format='table',
      range=false,
      instant=true,
    ),
  lokiDatasource::
    grafana.template.datasource.new(
      name='loki',
      label='Loki datasource',
      query='loki'
    ),
  lokiSimpleTarget::
    grafana.target.loki.new(
      datasource='$loki',
      expr='{cluster=~"(.+)"}'
    ),
  sentryDatasource::
    grafana.template.datasource.new(
      name='sentry',
      label='Sentry datasource',
      query='grafana-sentry-datasource'
    ),
  sentrySimpleTarget::
    grafana.target.sentry.new(
      datasource='$sentry',
    ),
  elasticsearchDatasource::
    grafana.template.datasource.new(
      name='elasticsearch',
      label='ElasticSearch datasource',
      query='elasticsearch'
    ),
  elasticsearchVariable::
    grafana.template.query.new(name='variable', multi=false, includeAll=false)
    .setDatasource(uid='$elasticsearch',)
    .setQuery(query='{"find": "terms", "field": "variable", "query": "var:value"}'),
  elasticsearchSimpleTarget::
    grafana.target.prometheus.new(
      datasource='$elasticsearch',
      expr='node_load1{job=~"$job",instance=~"$instance"}',
      legendFormat='{{instance}}'
    ),
  testdataDatasource::
    grafana.template.datasource.new(
      name='testdata',
      label='TestData DB datasource',
      query='testdata'
    ),
  testdataSimpleTarget::
    grafana.target.testdata.new(
      datasource='$testdata',
      csvContent='50%,70%,90%,100%\r\n0.4,0.6,0.8,1.0',
    ),
  intervalVariable::
    grafana.intervalTemplate(
      intervals='1m,10m,30m,1h,6h,12h,1d,7d,14d,30d',
    ),
}
