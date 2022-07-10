local defaults = import '../../defaults.libsonnet';
local resources = import './resources.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(title='Panel / Stat')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.alertmanagerDatasource)
.addTemplate(defaults.prometheusJobVariable)
.addTemplate(defaults.prometheusInstanceVariable)
.addTemplate(defaults.intervalVariable)
.addPanels(resources.panels())
