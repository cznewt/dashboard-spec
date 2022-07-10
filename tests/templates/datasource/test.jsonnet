local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(title='Template / Datasource')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.lokiDatasource)
.addTemplate(defaults.alertmanagerDatasource)
.addTemplate(defaults.elasticsearchDatasource)
.addTemplate(defaults.sentryDatasource)
