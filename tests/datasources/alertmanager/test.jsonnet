local defaults = import '../../defaults.libsonnet';
local resources = import './resources.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(title='Datasource / Alertmanager')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.alertmanagerDatasource)
.addTemplate(defaults.intervalVariable)
.addPanels(resources.panels())
