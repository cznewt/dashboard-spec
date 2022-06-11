local grafana = import 'grafonnet/grafana.libsonnet';

local basicTestPanel =
  grafana.panel.text.new(
    title='Basic test'
  );

local htmlTestPanel =
  grafana.panel.text.new(
    title='HTML test',
    description='description',

  )
  .setOptions(
    mode='html',
    content='<h1>coocoo<h1>',
  );

local markdownTestPanel =
  grafana.panel.text.new(
    title='Markdown test',
  )
  .setOptions(
    mode='markdown',
    content=|||
      # coocoo

      ## subheader
    |||,
  );

local repeatTestPanel =
  grafana.panel.text.new(
    title='Repeat test',
    repeat='variable',
    repeatDirection='v',
  )
  .setOptions(
    mode='markdown',
    content=|||
      # variable = $varialble
    |||,
  );

grafana.dashboard.new(title='Panel / Text')
.addPanel(basicTestPanel.setGridPos(h=6, w=8, x=0, y=0))
.addPanel(htmlTestPanel.setGridPos(h=6, w=8, x=8, y=0))
.addPanel(markdownTestPanel.setGridPos(h=6, w=8, x=16, y=0))
.addPanel(repeatTestPanel.setGridPos(h=8, w=12, x=0, y=8))
