local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(title='Template / Query')
.addTemplate(
  grafana.template.datasource.new(
    name='prometheus',
    label='Prometheus datasource',
    query='prometheus'
  )
)
.addTemplate(
  grafana.template.query.new(
    name='prometheus_single_param',
  )
  .setDatasource(uid='$prometheus',)
  .setQuery(query='label_values(up{job=~".+"}, job)')
)
.addTemplate(
  grafana.template.query.new(
    name='prometheus_multi_param',
    multi=true,
    includeAll=true
  )
  .setDatasource(uid='$prometheus',)
  .setQuery(query='label_values(up{job=~".+"}, instance)')
)
