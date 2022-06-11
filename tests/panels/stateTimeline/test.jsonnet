local grafana = import 'grafonnet/grafana.libsonnet';

local basicTestPanel =
  grafana.panel.stateTimeline.new(
    title='Basic test'
  )
  .addTarget(
    grafana.target.prometheus.new(
      expr='node_load1',
      legendFormat='{{instance}}'
    )
  );

local advancedTestPanel =
  grafana.panel.stateTimeline.new(
    title='Advanced test',
    description='description',
  )
  .setOptions(
    showValue='never'
  )
  .addTarget(
    grafana.target.prometheus.new(
      expr='node_load1',
      legendFormat='{{instance}}'
    )
  );

grafana.dashboard.new(title='Panel / State timeline')
.addPanels([
  basicTestPanel.setGridPos(h=6, w=8, x=0, y=0),
  advancedTestPanel.setGridPos(h=6, w=8, x=8, y=0),
])

/*
{    format:
      type: string
      default: time_series


  "targets": [
    {
      "refId": "A",
      "datasource": {
        "type": "prometheus",
        "uid": "P6693426190CB2316"
      },
      "expr": "node_load1",
      "editorMode": "code",
      "range": true,
      "legendFormat": "{{instance}}"
    }
  ],
  "options": {
    "mergeValues": true,
    "showValue": "never",
    "alignValue": "left",
    "rowHeight": 0.9,
    "legend": {
      "displayMode": "list",
      "placement": "bottom"
    },
    "tooltip": {
      "mode": "single",
      "sort": "none"
    }
  },
  "fieldConfig": {
    "defaults": {
      "custom": {
        "lineWidth": 0,
        "fillOpacity": 70,
        "spanNulls": false
      },
      "color": {
        "mode": "thresholds"
      },
      "mappings": [
        {
          "type": "value",
          "options": {
            "1": {
              "text": "OK",
              "index": 0
            }
          }
        }
      ],
      "thresholds": {
        "mode": "absolute",
        "steps": [
          {
            "color": "green",
            "value": null
          },
          {
            "color": "yellow",
            "value": 1
          },
          {
            "value": 2,
            "color": "red"
          }
        ]
      }
    },
    "overrides": []
  },
  "datasource": {
    "uid": "P6693426190CB2316",
    "type": "prometheus"
  }
}
*/
