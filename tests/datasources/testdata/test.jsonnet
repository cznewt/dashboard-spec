local defaults = import '../../defaults.libsonnet';
local resources = import './resources.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(title='Datasource / TestData / CSV content')
.addTemplate(defaults.testdataDatasource)
.addPanels(resources.csvContentPanels())
