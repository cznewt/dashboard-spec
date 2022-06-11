local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(title='Template / Datasource')
.addTemplate(
  grafana.template.datasource.new(
    name='prometheus',
    label='Prometheus datasource',
    query='prometheus'
  )
)
.addTemplate(
  grafana.template.datasource.new(
    name='loki',
    label='Loki datasource',
    query='loki'
  )
)
