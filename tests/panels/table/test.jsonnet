local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

local singleValueTestPanel =
  grafana.panel.table.new(
    title='Basic test'
  )
  .addTarget(defaults.tabularTarget);

local multiValuesTestPanel =
  grafana.panel.table.new(
    title='Advanced test',
    description='description',
  )
  .addTarget(defaults.tabularTarget)
  .addOverride(
    matcher={ id: 'byName', options: 'Value #A' },
    properties=[
      { id: 'custom.displayMode', value: 'basic' },
      { id: 'displayName', value: 'Load 1' },
      { id: 'noValue', value: 'N/A' },
    ]
  )
  .addTarget(defaults.secondTabularTarget)
  .addOverride(
    matcher={ id: 'byName', options: 'Value #B' },
    properties=[
      { id: 'custom.displayMode', value: 'lcd' },
      { id: 'displayName', value: 'Load 15' },
      { id: 'noValue', value: 'N/A' },
    ]
  );

grafana.dashboard.new(title='Panel / Table')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.jobVariable)
.addTemplate(defaults.instanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels([
  singleValueTestPanel.setGridPos(h=10, w=12, x=0, y=0),
  multiValuesTestPanel.setGridPos(h=10, w=12, x=12, y=0),
])
