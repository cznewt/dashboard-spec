local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

{
  simpleTableTestPanel::
    grafana.panel.table.new(
      title='Simple table (Sentry datasource)'
    )
    .addTarget(defaults.sentrySimpleTarget),

  simpleTimeSeriesPanel::
    grafana.panel.graph.new(
      title='Simple time series (Sentry datasource)',
    )
    .addTarget(defaults.sentrySimpleTarget),

  panels(y=0):: [
    grafana.panel.row.new(title='Sentry charts').setGridPos(h=1, w=24, x=0, y=y + 0),
    $.simpleTableTestPanel.setGridPos(h=20, w=12, x=0, y=y + 1),
    $.simpleTimeSeriesPanel.setGridPos(h=20, w=12, x=12, y=y + 1),
  ],
  panelsHeight:: 21,
}
