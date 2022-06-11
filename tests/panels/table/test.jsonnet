local grafana = import 'grafonnet/grafana.libsonnet';

local basicTestPanel =
  grafana.panel.table.new(
    title='Basic test'
  );

local advancedTestPanel =
  grafana.panel.table.new(
    title='Advanced test',
    description='description',
  );

grafana.dashboard.new(
  title='Panel / Table (old)'
)
.addTemplate(
  grafana.template.datasource.new(
    name='prometheus',
    label='Prometheus datasource',
    query='prometheus'
  )
)
.addPanels([
  basicTestPanel.setGridPos(h=6, w=8, x=0, y=0),
  advancedTestPanel.setGridPos(h=6, w=8, x=8, y=0),
])
