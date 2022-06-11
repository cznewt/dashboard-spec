local grafana = import 'grafonnet/grafana.libsonnet';

grafana.dashboard.new(
  title='Basic dashboard',
  editable=true,
  uid='foo',
  style='light',
  tags=['foo'],
  timezone='utc',
  refresh='1m',
  graphTooltip='shared_crosshair',
  description='test dashboard',
)
.setTime(
  from='now-6h'
)
