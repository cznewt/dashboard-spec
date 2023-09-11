local defaults = import '../../defaults.libsonnet';
local grafana = import 'grafonnet/grafana.libsonnet';

{
  simpleTableTestPanel::
    grafana.panel.table.new(
      title='Simple table (TestData datasource)',
      transformations=[
        {
          id: 'filterFieldsByName',
          options: {
            include: {
              names: ['50%', '70%', 'summary', 'description'],
            },
          },
        },
      ]
    )
    .addTarget(defaults.testdataSimpleTarget),

  simpleStatPanel::
    grafana.panel.stat.new(
      title='Simple stats (TestData datasource)',
    )
    .setOptions(
      values=false,
      calcs=[
        'lastNotNull',
      ],
      fields='',
      orientation='horizontal',
      textMode='name',
      colorMode='background',
      graphMode='none',
      justifyMode='auto'
    )
    .addTarget(defaults.testdataSimpleTarget)
    .addThresholdStep(color='red', value=null)
    .addThresholdStep(color='orange', value=0.5)
    .addThresholdStep(color='yellow', value=0.7)
    .addThresholdStep(color='green', value=0.9),

  csvContentPanels(y=0):: [
    grafana.panel.row.new(title='Testdata charts').setGridPos(h=1, w=24, x=0, y=y + 0),
    $.simpleTableTestPanel.setGridPos(h=20, w=12, x=0, y=y + 1),
    $.simpleStatPanel.setGridPos(h=20, w=12, x=12, y=y + 1),
  ],
  panelsHeight:: 21,
}
