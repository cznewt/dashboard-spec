local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

{

  basicTestPanel::
    grafana.panel.stat.new(
      title='Basic test',
    )
    .setOptions(
    )
    .addTarget(defaults.prometheusSimpleTarget),

  advancedTestPanel::
    grafana.panel.stat.new(
      title='Advanced test',
      description='description',
    )
    .setOptions(
    )
    .addTarget(defaults.prometheusSingleInstantTarget),

  repeatTestPanel::
    grafana.panel.stat.new(
      title='Advanced test',
      description='description',
    )
    .setOptions(
    )
    .addTarget(defaults.prometheusSingleInstantTarget),


  mappingTestPanel::
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
    .addTarget(defaults.prometheusSingleInstantTarget),

  alertmangerCriticalTestPanel::
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
    .addThresholdStep(color='red', value=10),

  alertmangerWarningTestPanel::
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
    .addThresholdStep(color='red', value=10),

  alertmangerInfoTestPanel::
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
    .addThresholdStep(color='red', value=100),

  panels(y=0):: [
    grafana.panel.row.new(title='Stat panels').setGridPos(h=1, w=24, x=0, y=y + 0),
    $.basicTestPanel.setGridPos(h=6, w=8, x=0, y=y + 1),
    $.advancedTestPanel.setGridPos(h=6, w=8, x=8, y=y + 1),
    $.mappingTestPanel.setGridPos(h=6, w=8, x=16, y=y + 1),
    $.repeatTestPanel.setGridPos(h=6, w=12, x=0, y=y + 7),
    $.alertmangerCriticalTestPanel.setGridPos(h=6, w=6, x=0, y=y + 13),
    $.alertmangerWarningTestPanel.setGridPos(h=6, w=6, x=0, y=y + 19),
    $.alertmangerInfoTestPanel.setGridPos(h=6, w=6, x=0, y=y + 25),
  ],
  panelsHeight:: 31,
}
