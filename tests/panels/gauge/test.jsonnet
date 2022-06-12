local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

local basicTestPanel =
  grafana.panel.gauge.new(
    title='Basic test'
  ).addTarget(
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='node_load1{job=~"$job",instance=~"$instance"}',
      legendFormat='{{instance}}'
    )
  );

local advancedTestPanel =
  grafana.panel.gauge.new(
    title='Advanced test',
    description='description',
  )
  .setOptions(
  );

local mappingTestPanel =
  grafana.panel.gauge.new(
    title='Mapping test',
  )
  .setOptions(
  );

local repeatTestPanel =
  grafana.panel.gauge.new(
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

grafana.dashboard.new(title='Panel / gauge')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.jobVariable)
.addTemplate(defaults.instanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels([
  basicTestPanel.setGridPos(h=6, w=8, x=0, y=0),
  advancedTestPanel.setGridPos(h=6, w=8, x=8, y=0),
  mappingTestPanel.setGridPos(h=6, w=8, x=16, y=0),
  repeatTestPanel.setGridPos(h=4, w=12, x=0, y=8),
])
