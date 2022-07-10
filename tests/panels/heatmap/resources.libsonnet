local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

{
  basicTestPanel::
    grafana.panel.heatmap.new(title='Basic test')
    .addTarget(defaults.prometheusBucketTarget),

  advancedTestPanel::
    grafana.panel.heatmap.new(title='Advanced test',)
    .addTarget(defaults.prometheusBucketTarget),

  panels(y=0):: [
    grafana.panel.row.new(title='Heatmap panels').setGridPos(h=1, w=24, x=0, y=y + 0),
    $.basicTestPanel.setGridPos(h=12, w=12, x=0, y=y + 1),
    $.advancedTestPanel.setGridPos(h=12, w=12, x=12, y=y + 1),
  ],
  panelsHeight:: 13,
}
