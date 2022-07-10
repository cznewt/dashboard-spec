local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

{
  simpleTableTestPanel::
    grafana.panel.logs.new(
      title='Simple table (Loki datasource)'
    )
    .addTarget(defaults.lokiSimpleTarget),

  prettyTableTestPanel::
    grafana.panel.logs.new(
      title='Pretty table (Loki datasource)',
    )
    .setOptions(
      prettifyLogMessage=true
    )
    .addTarget(defaults.lokiSimpleTarget),

  panels(y=0):: [
    grafana.panel.row.new(title='Logs panels').setGridPos(h=1, w=24, x=0, y=y + 0),
    $.simpleTableTestPanel.setGridPos(h=20, w=12, x=0, y=y + 1),
    $.prettyTableTestPanel.setGridPos(h=20, w=12, x=12, y=y + 1),
  ],
  panelsHeight:: 21,
}
