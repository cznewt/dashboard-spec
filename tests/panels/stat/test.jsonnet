local grafana = import 'grafonnet/grafana.libsonnet';

local basicTestPanel =
  grafana.panel.stat.new(
    title='Basic test'
  );

local advancedTestPanel =
  grafana.panel.stat.new(
    title='Advanced test',
    description='description',
  )
  .setOptions(
  );

local repeatTestPanel =
  grafana.panel.stat.new(
    title='Repeat test',
    repeat='my-variable'
  );

grafana.dashboard.new(title='Panel / Stat')
.addPanels([
  basicTestPanel.setGridPos(h=6, w=8, x=0, y=0),
  advancedTestPanel.setGridPos(h=6, w=8, x=8, y=0),
  repeatTestPanel.setGridPos(h=8, w=12, x=0, y=8),
])
