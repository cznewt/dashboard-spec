local defaults = import '../defaults.libsonnet';
local barGaugeResources = import '../panels/barGauge/resources.libsonnet';
local gaugeResources = import '../panels/gauge/resources.libsonnet';
local logsResources = import '../panels/logs/resources.libsonnet';
local statResources = import '../panels/stat/resources.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(title='Panels demo')
.setTime(from='now-6h')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.lokiDatasource)
.addTemplate(defaults.alertmanagerDatasource)
.addTemplate(defaults.prometheusJobVariable)
.addTemplate(defaults.prometheusInstanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels(barGaugeResources.panels(y=0))
.addPanels(gaugeResources.panels(
  y=barGaugeResources.panelsHeight
))
.addPanels(logsResources.panels(
  y=barGaugeResources.panelsHeight
    + gaugeResources.panelsHeight
))
.addPanels(statResources.panels(
  y=barGaugeResources.panelsHeight
    + gaugeResources.panelsHeight
    + logsResources.panelsHeight
))
