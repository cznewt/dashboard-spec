local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

local linesTestPanel =
  grafana.panel.graph.new(
    title='Lines test'
  )
  .addTarget(defaults.simpleTarget);

local barsTestPanel =
  grafana.panel.graph.new(
    title='Bars test',
    bars=true,
    lines=false,
  )
  .addTarget(defaults.simpleTarget);

local dashesTestPanel =
  grafana.panel.graph.new(
    title='Dashes test',
    dashes=true,
    lines=false,
  )
  .addTarget(defaults.simpleTarget);

local repeatTestPanel =
  grafana.panel.graph.new(
    title='Repeat $instance test',
    repeat='instance'
  )
  .addTarget(
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='node_load1{job=~"$job",instance="$instance"}',
      legendFormat='{{instance}}'
    )
  );

grafana.dashboard.new(title='Panel / graph')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.jobVariable)
.addTemplate(defaults.instanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels([
  linesTestPanel.setGridPos(h=6, w=8, x=0, y=0),
  barsTestPanel.setGridPos(h=6, w=8, x=8, y=0),
  dashesTestPanel.setGridPos(h=6, w=8, x=16, y=0),
  repeatTestPanel.setGridPos(h=4, w=12, x=0, y=8),
])
