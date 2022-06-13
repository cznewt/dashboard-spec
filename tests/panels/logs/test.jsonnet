local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

local simpleTableTestPanel =
  grafana.panel.logs.new(
    title='Simple table'
  )
  .addTarget(defaults.lokiSimpleTarget);

local prettyTableTestPanel =
  grafana.panel.logs.new(
    title='Pretty table',
  )
  .setOptions(
    prettifyLogMessage=true
  )
  .addTarget(defaults.lokiSimpleTarget);

grafana.dashboard.new(title='Panel / Logs')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.lokiDatasource)
.addTemplate(defaults.jobVariable)
.addTemplate(defaults.instanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels([
  simpleTableTestPanel.setGridPos(h=20, w=12, x=0, y=0),
  prettyTableTestPanel.setGridPos(h=20, w=12, x=12, y=0),
])
