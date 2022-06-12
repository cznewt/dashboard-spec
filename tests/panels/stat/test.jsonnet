local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

local basicTestPanel =
  grafana.panel.stat.new(
    title='Basic test'
  ).addTarget(defaults.simpleTarget);

local advancedTestPanel =
  grafana.panel.stat.new(
    title='Advanced test',
    description='description',
  )
  .setOptions(
  );

local mappingTestPanel =
  grafana.panel.stat.new(
    title='Mapping test',
  )
  .setOptions(
  );

local repeatTestPanel =
  grafana.panel.stat.new(
    title='Repeat $instance test',
    repeat='instance'
  )
  .addTarget(defaults.simpleTarget);

grafana.dashboard.new(title='Panel / Stat')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.jobVariable)
.addTemplate(defaults.instanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels([
  basicTestPanel.setGridPos(h=6, w=8, x=0, y=0),
  advancedTestPanel.setGridPos(h=6, w=8, x=8, y=0),
  mappingTestPanel.setGridPos(h=6, w=8, x=16, y=0),
  repeatTestPanel.setGridPos(h=4, w=12, x=0, y=8),
])
