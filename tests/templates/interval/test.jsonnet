local grafana = import 'grafonnet/grafana.libsonnet';

local testPanel =
  grafana.panel.text.new(title='Interval test:  $interval',)
  .setOptions(
    mode='markdown',
    content=|||
      ...
    |||,
  );

grafana.dashboard.new(title='Template / Interval')
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
  .setQuery(query='label_values(up{job=~".+"}, cluster)')
)
.addTemplate(
  grafana.intervalTemplate(
    intervals='1m,10m,30m,1h,6h,12h,1d,7d,14d,30d',
  )
)
.addPanel(testPanel.setGridPos(h=10, w=12, x=0, y=0))
