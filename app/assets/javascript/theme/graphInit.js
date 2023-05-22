const formatGraphName = (str) => {
  return str.replace(/-/g, '_');
}

const getPosition = (pos, params, dom, rect, size) => {
  return {
    top: pos[1] - size.contentSize[1] - 10,
    left: pos[0] - size.contentSize[0] / 2,
  };
};

const composeOptions = (divClass, options = {}) => {
  const echart_bar_weekly_sales = {
    tooltip: {
      trigger: "axis",
      padding: [7, 10],
      formatter: "{b0} : {c0}",
      transitionDuration: 0,
      backgroundColor: getGrays()["100"],
      borderColor: getGrays()["300"],
      textStyle: {
        color: getColors().dark,
      },
      borderWidth: 1,
      position: function position(pos, params, dom, rect, size) {
        return getPosition(pos, params, dom, rect, size);
      },
    },
    xAxis: {
      type: "category",
      data: options.xAxisData,
      boundaryGap: false,
      axisLine: {
        show: false,
      },
      axisLabel: {
        show: false,
      },
      axisTick: {
        show: false,
      },
      axisPointer: {
        type: "none",
      },
    },
    yAxis: {
      type: "value",
      splitLine: {
        show: false,
      },
      axisLine: {
        show: false,
      },
      axisLabel: {
        show: false,
      },
      axisTick: {
        show: false,
      },
      axisPointer: {
        type: "none",
      },
    },
    series: [
      {
        type: "bar",
        showBackground: true,
        backgroundStyle: {
          borderRadius: 10,
        },
        barWidth: "5px",
        itemStyle: {
          barBorderRadius: 10,
          color: getColors().primary,
        },
        data: options.data,
        z: 10,
        emphasis: {
          itemStyle: {
            color: getColors().primary,
          },
        },
      },
    ],
    grid: {
      right: 5,
      left: 10,
      top: 0,
      bottom: 0,
    },
  }
  const echart_default_total_order = {
    tooltip: {
      trigger: "axis",
      formatter: "{b0} : {c0}"
    },
    xAxis: {
      type: "category",
      data: options.xAxisData
    },
    series: [
      { type: "line", data: options.data, smooth: true, lineStyle: { width: 3 } }
    ],
    grid: {
      bottom: "2%",
      top: "2%",
      right: "10px",
      left: "10px"
    }
  }
  const echart_stacked_area_chart = {
    tooltip: {
      trigger: 'axis',
      padding: [7, 10],
      backgroundColor: getGrays()['100'],
      borderColor: getGrays()['300'],
      textStyle: {
        color: getColors().dark
      },
      borderWidth: 1,
      transitionDuration: 0,
      position: function position(pos, params, dom, rect, size) {
        return getPosition(pos, params, dom, rect, size);
      },
      axisPointer: {
        type: 'none'
      },
      formatter: tooltipFormatter
    },
    xAxis: {
      type: 'category',
      data: options.days,
      boundaryGap: false,
      axisLine: {
        lineStyle: {
          color: getGrays()['300'],
          type: 'solid'
        }
      },
      axisTick: {
        show: false
      },
      axisLabel: {
        color: getGrays()['400'],
        margin: 15,
        formatter: function formatter(value) {
          return value.substring(0, 3);
        }
      },
      splitLine: {
        show: false
      }
    },
    yAxis: {
      type: 'value',
      splitLine: {
        lineStyle: {
          color: getGrays()['200']
        }
      },
      boundaryGap: false,
      axisLabel: {
        show: true,
        color: getGrays()['400'],
        margin: 15
      },
      axisTick: {
        show: false
      },
      axisLine: {
        show: false
      }
    },
    series: options.series,
    grid: {
      right: 10,
      left: 5,
      bottom: 5,
      top: 8,
      containLabel: true
    }
  }
  const echart_line_marker_chart = {
    color: [getColor('primary'), getColor('warning') // getColor('danger')
    ],
    legend: {
      data: [{
        name: 'Max',
        textStyle: {
          color: getGrays()['600']
        }
      }, {
        name: 'Min',
        textStyle: {
          color: getGrays()['600']
        }
      }]
    },
    tooltip: {
      trigger: 'axis',
      padding: [7, 10],
      backgroundColor: getGrays()['100'],
      borderColor: getGrays()['300'],
      textStyle: {
        color: getColors().dark
      },
      borderWidth: 1,
      transitionDuration: 0,
      position: function position(pos, params, dom, rect, size) {
        return getPosition(pos, params, dom, rect, size);
      },
      axisPointer: {
        type: 'none'
      },
      formatter: tooltipFormatter
    },
    xAxis: {
      type: 'category',
      data: options.days,
      boundaryGap: false,
      axisLine: {
        lineStyle: {
          color: getGrays()['300'],
          type: 'solid'
        }
      },
      axisTick: {
        show: false
      },
      axisLabel: {
        formatter: function formatter(value) {
          return value.substring(0, 3);
        },
        color: getGrays()['400'],
        margin: 15
      },
      splitLine: {
        show: false
      }
    },
    yAxis: {
      type: 'value',
      splitLine: {
        lineStyle: {
          color: getGrays()['200']
        }
      },
      boundaryGap: false,
      axisLabel: {
        show: true,
        color: getGrays()['400'],
        margin: 15
      },
      axisTick: {
        show: false
      },
      axisLine: {
        show: false
      }
    },
    series: options.series,
    grid: {
      right: '8%',
      left: '5%',
      bottom: '10%',
      top: '15%'
    }
  }
  const optionsMapping = {
    echart_bar_weekly_sales,
    echart_default_total_order,
    echart_stacked_area_chart,
    echart_line_marker_chart
  }
  // echart_bar_weekly_sales, echart_default_total_order
  // xAxisData, data
  // echart-stacked-area-chart, echart-line-marker-chart
  // days, series

  return optionsMapping[formatGraphName(divClass)]
}

const echartSetOption = (
  chart,
  userOptions,
  getDefaultOptions
) => {
  const themeController = document.body; // Merge user options with lodash

  chart.setOption(window._.merge(getDefaultOptions(), userOptions));
  themeController.addEventListener("clickControl", function (_ref15) {
    const control = _ref15.detail.control;

    if (control === "theme") {
      chart.setOption(window._.merge(getDefaultOptions(), userOptions));
    }
  });
};

window.graphInit = (divClass, options = {}) => {
  const ECHART_GRAPH_CLASS = `.${divClass}`;

  const $echartGraph = document.querySelector(ECHART_GRAPH_CLASS);

  if ($echartGraph) {
    const userOptions = window.getData($echartGraph, "options");

    // const yMax = Math.max.apply(Math, options.data);
    // const dataBackground = options.data.map(function () {
    //   return yMax;
    // });

    const chart = window.echarts.init($echartGraph);

    const getDefaultOptions = function getDefaultOptions() {
      return composeOptions(divClass, options);
    };

    echartSetOption(chart, userOptions, getDefaultOptions);
  }
}
