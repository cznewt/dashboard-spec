local grafana = import 'grafonnet/grafana.libsonnet';

{
  simpleTarget::
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='node_load1{job=~"$job",instance=~"$instance"}',
      legendFormat='{{instance}}'
    ),
  tabularTarget::
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='sum by (job, instance) (node_load1{job=~"$job",instance=~"$instance"})',
      format='table',
      range=false,
      instant=true,
    ),
  secondTabularTarget::
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='sum by (job, instance) (node_load15{job=~"$job",instance=~"$instance"})',
      format='table',
      range=false,
      instant=true,
    ),
  prometheusDatasource::
    grafana.template.datasource.new(
      name='prometheus',
      label='Prometheus datasource',
      query='prometheus'
    ),
  jobVariable::
    grafana.template.query.new(
      name='job',
      multi=true,
      includeAll=true
    )
    .setDatasource(uid='$prometheus',)
    .setQuery(query='label_values(node_load1{job=~".+"}, job)'),
  instanceVariable::
    grafana.template.query.new(
      name='instance',
      multi=true,
      includeAll=true
    )
    .setDatasource(uid='$prometheus',)
    .setQuery(query='label_values(node_load1{job=~"$job"}, instance)'),
  intervalVariable::
    grafana.intervalTemplate(
      intervals='1m,10m,30m,1h,6h,12h,1d,7d,14d,30d',
    ),
}
