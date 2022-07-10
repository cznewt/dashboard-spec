local defaults = import '../../defaults.libsonnet';
local resources = import './resources.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(title='Panel / Heatmap')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.prometheusJobVariable)
.addTemplate(defaults.prometheusInstanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels(resources.panels())
