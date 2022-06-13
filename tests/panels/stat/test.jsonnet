local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

local basicTestPanel =
  grafana.panel.stat.new(
    title='Basic test',
  )
  .setOptions(
  )
  .addTarget(defaults.simpleTarget);

local advancedTestPanel =
  grafana.panel.stat.new(
    title='Advanced test',
    description='description',
  )
  .setOptions(
  )
  .addTarget(defaults.prometheusSingleInstantTarget);

local mappingTestPanel =
  grafana.panel.stat.new(
    title='Mapping test',
  )
  .addMapping(type='range', options={
    from: 0,
    to: 1,
    result: {
      text: 'OK',
      index: 1,
    },
  })
  .addMapping(type='range', options={
    from: 1,
    to: 1000,
    result: {
      text: 'Warning',
      index: 1,
    },
  })
  .addTarget(defaults.prometheusSingleInstantTarget);

local alertmangerCriticalTestPanel =
  grafana.panel.stat.new(
    title='${instance} critical (Alertmanager datasource)',
    repeat='instance',
    transformations=[
      {
        id: 'reduce',
        options: {
          includeTimeField: false,
          mode: 'seriesToRows',
          reducers: ['count'],
        },
      },
    ]
  )
  .setFieldConfig(
    noValue='0'
  )
  .setOptions(
    values=false,
    calcs=['lastNotNull'],
    fields=''
  )
  .addTarget(defaults.alertmanagerCriticalTarget)
  .addThresholdStep(color='green', value=null)
  .addThresholdStep(color='yellow', value=1)
  .addThresholdStep(color='red', value=10);

local alertmangerWarningTestPanel =
  grafana.panel.stat.new(
    title='${instance} warning (Alertmanager datasource)',
    repeat='instance',
    transformations=[
      {
        id: 'reduce',
        options: {
          includeTimeField: false,
          mode: 'seriesToRows',
          reducers: ['count'],
        },
      },
    ]
  )
  .setFieldConfig(
    noValue='0',
    displayName='${instance}',
  )
  .setOptions(
    graphMode='area',
    values=false,
    calcs=['lastNotNull'],
    fields='',
    colorMode='background',
  )
  .addTarget(defaults.alertmanagerWarningTarget)
  .addThresholdStep(color='green', value=null)
  .addThresholdStep(color='yellow', value=1)
  .addThresholdStep(color='red', value=10);

local alertmangerInfoTestPanel =
  grafana.panel.stat.new(
    title='${instance} info (Alertmanager datasource)',
    repeat='instance',
    transformations=[
      {
        id: 'reduce',
        options: {
          includeTimeField: false,
          mode: 'seriesToRows',
          reducers: ['count'],
        },
      },
    ]
  )
  .setFieldConfig(
    noValue='0',
    displayName='${instance}',
  )
  .setOptions(
    values=false,
    calcs=['lastNotNull'],
    fields='',
    colorMode='background',
  )
  .addTarget(defaults.alertmanagerInfoTarget)
  .addThresholdStep(color='green', value=null)
  .addThresholdStep(color='yellow', value=10)
  .addThresholdStep(color='red', value=100);

local repeatTestPanel =
  grafana.panel.stat.new(
    title='Repeat $instance test',
    repeat='instance'
  )
  .addTarget(defaults.simpleTarget);

grafana.dashboard.new(title='Panel / Stat')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.alertmanagerDatasource)
.addTemplate(defaults.jobVariable)
.addTemplate(defaults.instanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels([
  basicTestPanel.setGridPos(h=6, w=8, x=0, y=0),
  advancedTestPanel.setGridPos(h=6, w=8, x=8, y=0),
  mappingTestPanel.setGridPos(h=6, w=8, x=16, y=0),
  repeatTestPanel.setGridPos(h=6, w=12, x=0, y=6),
  alertmangerCriticalTestPanel.setGridPos(h=6, w=6, x=0, y=12),
  alertmangerWarningTestPanel.setGridPos(h=6, w=6, x=0, y=18),
  alertmangerInfoTestPanel.setGridPos(h=6, w=6, x=0, y=24),
])
