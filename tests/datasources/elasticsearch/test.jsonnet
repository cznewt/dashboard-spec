local defaults = import '../../defaults.libsonnet';
local resources = import './resources.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(title='Datasource / Elasticsearch')
.addTemplate(defaults.prometheusDatasource)
.addTemplate(defaults.elasticsearchDatasource)
.addTemplate(defaults.intervalVariable)
.addPanels(resources.panels())
