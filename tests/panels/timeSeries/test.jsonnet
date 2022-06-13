local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

local linesTestPanel =
  grafana.panel.graph.new(
    title='Line chart'
  )
  .addTarget(defaults.simpleTarget);

local barsTestPanel =
  grafana.panel.graph.new(
    title='Bar chart',
    bars=true,
    lines=false,
  )
  .addTarget(defaults.simpleTarget);

local pointsTestPanel =
  grafana.panel.graph.new(
    title='Point chart',
    points=true,
    lines=false,
  )
  .addTarget(defaults.simpleTarget);

local repeatTestPanel =
  grafana.panel.graph.new(
    title='Repeat $instance',
    repeat='instance',
    bars=true,
    lines=false,
  )
  .addTarget(
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='node_load1{job=~"$job",instance="$instance"}',
      legendFormat='{{instance}}'
    )
  );

grafana.dashboard.new(title='Panel / Time series')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.alertmanagerDatasource)
.addTemplate(defaults.jobVariable)
.addTemplate(defaults.instanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels([
  linesTestPanel.setGridPos(h=6, w=8, x=0, y=0),
  barsTestPanel.setGridPos(h=6, w=8, x=8, y=0),
  pointsTestPanel.setGridPos(h=6, w=8, x=16, y=0),
  repeatTestPanel.setGridPos(h=6, w=12, x=0, y=6),
])
