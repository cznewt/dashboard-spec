local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

local basicTestPanel =
  grafana.panel.stateTimeline.new(
    title='Basic test'
  )
  .addTarget(defaults.prometheusSimpleTarget);

local advancedTestPanel =
  grafana.panel.stateTimeline.new(
    title='Advanced test',
    description='description',
  )
  .setOptions(showValue='never')
  .addTarget(defaults.prometheusSimpleTarget)
  .addThresholdStep(color='green', value=null)
  .addThresholdStep(color='yellow', value=1)
  .addThresholdStep(color='red', value=2);

grafana.dashboard.new(title='Panel / State timeline')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.prometheusJobVariable)
.addTemplate(defaults.prometheusInstanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels([
  grafana.panel.text.new()
  .setOptions(
    mode='markdown',
    content=|||
      ```
      grafana.panel.stateTimeline.new(
        title='Basic test'
      )
      .addTarget(
        grafana.target.prometheus.new(
          datasource='$prometheus',
          expr='node_load1{job=~"$job",instance=~"$instance"}',
          legendFormat='{{instance}}'
        )
      );
      ```
    |||,
  )
  .setGridPos(h=6, w=12, x=0, y=0),
  basicTestPanel.setGridPos(h=12, w=12, x=0, y=6),
  grafana.panel.text.new()
  .setOptions(
    mode='markdown',
    content=|||
      ```
      grafana.panel.stateTimeline.new(
        title='Advanced test',
        description='description',
      )
      .setOptions(showValue='never')
      .addTarget(
        grafana.target.prometheus.new(
          datasource='$prometheus',
          expr='node_load1{job=~"$job",instance=~"$instance"}',
          legendFormat='{{instance}}'
        )
      )
      //.addMapping(type='range', from=1, to=2, text='OK',)
      .addThresholdStep(color='green', value=null)
      .addThresholdStep(color='yellow', value=1)
      .addThresholdStep(color='red', value=2);
      ```
    |||,
  )
  .setGridPos(h=6, w=12, x=12, y=0),
  advancedTestPanel.setGridPos(h=12, w=12, x=12, y=6),
])
