local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

{
  lcdHorizontalPanel::
    grafana.panel.barGauge.new(title='Horizontal LCD bar gauge')
    .setOptions(orientation='horizontal')
    .addThresholdStep(color='blue', value=null)
    .addThresholdStep(color='green', value=0.5)
    .addThresholdStep(color='yellow', value=1)
    .addThresholdStep(color='red', value=2)
    .addTarget(defaults.prometheusSimpleTarget),

  lcdVerticalPanel::
    grafana.panel.barGauge.new(title='Vertical LCD bar gauge',)
    .setOptions(orientation='vertical')
    .addThresholdStep(color='blue', value=null)
    .addThresholdStep(color='green', value=0.5)
    .addThresholdStep(color='yellow', value=1)
    .addThresholdStep(color='red', value=2)
    .addTarget(defaults.prometheusSimpleTarget),

  gradientHorizontalPanel::
    grafana.panel.barGauge.new(title='Horizontal gradient bar gauge')
    .setOptions(orientation='horizontal', displayMode='gradient')
    .addThresholdStep(color='blue', value=null)
    .addThresholdStep(color='green', value=0.5)
    .addThresholdStep(color='yellow', value=1)
    .addThresholdStep(color='red', value=2)
    .addTarget(defaults.prometheusSimpleTarget),

  gradientVerticalPanel::
    grafana.panel.barGauge.new(title='Vertical gradient bar gauge',)
    .setOptions(orientation='vertical', displayMode='gradient')
    .addThresholdStep(color='blue', value=null)
    .addThresholdStep(color='green', value=0.5)
    .addThresholdStep(color='yellow', value=1)
    .addThresholdStep(color='red', value=2)
    .addTarget(defaults.prometheusSimpleTarget),

  panels(y=0):: [
    grafana.panel.row.new(title='Bar gauge panels').setGridPos(h=1, w=24, x=0, y=y + 0),
    $.lcdHorizontalPanel.setGridPos(h=8, w=12, x=0, y=y + 1),
    $.lcdVerticalPanel.setGridPos(h=8, w=12, x=12, y=y + 1),
    $.gradientHorizontalPanel.setGridPos(h=8, w=16, x=0, y=y + 9),
    $.gradientVerticalPanel.setGridPos(h=8, w=8, x=16, y=y + 9),
  ],
  panelsHeight:: 17,
}
