const y = {
  tooltip: {
    trigger: "axis",
    formatter: "{b0} : {c0}"
  },
  xAxis: {
    data: ["Week 4","Week 5","week 6","week 7"]
  },
  series: [
    { type: "line", data: [20,40,100,120], smooth: true, lineStyle: { width: 3 } }
  ],
  grid: {
    bottom: "2%",
    top: "2%",
    right: "10px",
    left: "10px"
  }
}

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
  const optionsMapping = {
    echart_bar_weekly_sales,
    echart_default_total_order
  }
  // echart_bar_weekly_sales, echart_default_total_order
  // xAxisData, data

  return optionsMapping[formatGraphName(divClass)]
}

const echartSetOption = function echartSetOption(
  chart,
  userOptions,
  getDefaultOptions
) {
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
  const ECHART_BAR_WEEKLY_SALES = `.${divClass}`;
  const $echartBarWeeklySales = document.querySelector(ECHART_BAR_WEEKLY_SALES);

  if ($echartBarWeeklySales) {
    const userOptions = window.getData($echartBarWeeklySales, "options");

    const yMax = Math.max.apply(Math, options.data);
    const dataBackground = options.data.map(function () {
      return yMax;
    });
    const chart = window.echarts.init($echartBarWeeklySales);

    const getDefaultOptions = function getDefaultOptions() {
      return composeOptions(divClass, options);
    };

    echartSetOption(chart, userOptions, getDefaultOptions);
  }
}
