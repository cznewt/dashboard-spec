local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

{
  basicDiagramPanel::
    grafana.panel.diagram.new(title='Basic diagram')
    .setOptions(content='graph LR\n      D --> E\n')
    .addTarget(defaults.prometheusSimpleTarget),

  panels(y=0):: [
    grafana.panel.row.new(title='Diagram panels').setGridPos(h=1, w=24, x=0, y=y + 0),
    $.basicDiagramPanel.setGridPos(h=8, w=12, x=0, y=y + 1),
  ],
  panelsHeight:: 17,
}
