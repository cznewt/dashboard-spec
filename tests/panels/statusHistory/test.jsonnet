local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

local basicTestPanel =
  grafana.panel.statusHistory.new(
    title='Basic test'
  )
  .addTarget(
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='node_load1{job=~"$job",instance=~"$instance"}',
      legendFormat='{{instance}}'
    )
  );

local advancedTestPanel =
  grafana.panel.statusHistory.new(
    title='Advanced test (per $interval)',
    description='description',
  )
  .setOptions(showValue='never')
  .addTarget(
    grafana.target.prometheus.new(
      datasource='$prometheus',
      expr='avg_over_time(node_load1{job=~"$job",instance=~"$instance"}[$interval]',
      legendFormat='{{instance}}'
    )
  )
  //.addMapping(type='range', from=1, to=2, text='OK',)
  .addThresholdStep(color='green', value=null)
  .addThresholdStep(color='yellow', value=1)
  .addThresholdStep(color='red', value=2);

grafana.dashboard.new(title='Panel / State timeline')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.prometheusJobVariable)
.addTemplate(defaults.prometheusInstanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels([
  basicTestPanel.setGridPos(h=12, w=12, x=0, y=0),
  advancedTestPanel.setGridPos(h=12, w=12, x=12, y=0),
])
