local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

{
  basicTestPanel::
    grafana.panel.gauge.new(title='Basic test')
    .addTarget(defaults.prometheusSimpleTarget),

  advancedTestPanel::
    grafana.panel.gauge.new(title='Advanced test',)
    .setOptions()
    .addTarget(defaults.prometheusSingleInstantTarget),

  repeatTestPanel::
    grafana.panel.gauge.new(title='Repeat $instance test', repeat='instance')
    .setFieldConfig(max=5, min=0, thresholdMode='absolute')
    .addThresholdStep(color='blue', value=null)
    .addThresholdStep(color='green', value=0.5)
    .addThresholdStep(color='yellow', value=1)
    .addThresholdStep(color='red', value=2)
    .addTarget(defaults.prometheusSimpleTarget),

  panels(y=0):: [
    grafana.panel.row.new(title='Gauge panels').setGridPos(h=1, w=24, x=0, y=y + 0),
    $.basicTestPanel.setGridPos(h=6, w=16, x=0, y=y + 1),
    $.advancedTestPanel.setGridPos(h=6, w=8, x=16, y=y + 1),
    $.repeatTestPanel.setGridPos(h=8, w=12, x=0, y=y + 9),
  ],
  panelsHeight:: 17,
}
