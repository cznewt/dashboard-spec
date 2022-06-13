local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

local basicTestPanel =
  grafana.panel.gauge.new(
    title='Basic test'
  )
  .addTarget(defaults.simpleTarget);

local advancedTestPanel =
  grafana.panel.gauge.new(
    title='Advanced test',
    description='description',
  )
  .setOptions(
  )
  .addTarget(defaults.prometheusSingleInstantTarget);

local repeatTestPanel =
  grafana.panel.gauge.new(
    title='Repeat $instance test',
    repeat='instance'
  )
  .setFieldConfig(
    max=5,
    min=0,
    thresholdMode='absolute'
  )
  .addTarget(defaults.simpleTarget);

grafana.dashboard.new(title='Panel / Gauge')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.jobVariable)
.addTemplate(defaults.instanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels([
  basicTestPanel.setGridPos(h=6, w=16, x=0, y=0),
  advancedTestPanel.setGridPos(h=6, w=8, x=16, y=0),
  repeatTestPanel.setGridPos(h=8, w=12, x=0, y=8),
])
