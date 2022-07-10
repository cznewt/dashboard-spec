local defaults = import '../../defaults.libsonnet';
local resources = import './resources.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(title='Datasource / Sentry')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.sentryDatasource)
.addTemplate(defaults.intervalVariable)
.addPanels(resources.panels())
