// Create root element
// https://www.amcharts.com/docs/v5/getting-started/#Root_element
var root = am5.Root.new("chartdiv");
root.locale = am5locales_vi_VN;
root.dateFormatter.setAll({
  dateFormat: "dd-MM-yyyy",
  dateFields: ["valueX"]
});

root.setThemes([
  am5themes_Animated.new(root)
]);

var chart = root.container.children.push(
    am5xy.XYChart.new(root, {
      panX: true,
      panY: true,
      wheelX: "panX",
      wheelY: "zoomX"
    })
);

chart.get("colors").set("step", 3);

var cursor = chart.set("cursor", am5xy.XYCursor.new(root, {}));
cursor.lineY.set("visible", false);

var xAxis = chart.xAxes.push(
    am5xy.DateAxis.new(root, {
      maxDeviation: 0.3,
      baseInterval: {
        timeUnit: "day",
        count: 1
      },
      renderer: am5xy.AxisRendererX.new(root, {}),
      tooltip: am5.Tooltip.new(root, {})
    })
);

var yAxis = chart.yAxes.push(
    am5xy.ValueAxis.new(root, {
      maxDeviation: 0.3,
      renderer: am5xy.AxisRendererY.new(root, {})
    })
);


var series = chart.series.push(am5xy.LineSeries.new(root, {
  name: "Series 1",
  xAxis: xAxis,
  yAxis: yAxis,
  valueYField: "value",
  valueXField: "date",
  tooltip: am5.Tooltip.new(root, {
    labelText: "Lượt truy cập: {valueY}"
  })
}));
series.strokes.template.setAll({
  strokeWidth: 2,
  strokeDasharray: [3, 3]
});

// Create animating bullet by adding two circles in a bullet container and
// animating radius and opacity of one of them.

// series.bullets.push(function () {
//   var container = am5.Container.new(root, {
//     templateField: "bulletSettings"
//   });
//   var circle0 = container.children.push(am5.Circle.new(root, {
//     radius: 5,
//     fill: am5.color(0xff0000)
//   }));
//   var circle1 = container.children.push(am5.Circle.new(root, {
//     radius: 5,
//     fill: am5.color(0xff0000)
//   }));
//
//   circle1.animate({
//     key: "radius",
//     to: 20,
//     duration: 1000,
//     easing: am5.ease.out(am5.ease.cubic),
//     loops: Infinity
//   });
//   circle1.animate({
//     key: "opacity",
//     to: 0,
//     from: 1,
//     duration: 1000,
//     easing: am5.ease.out(am5.ease.cubic),
//     loops: Infinity
//   });
//
//   return am5.Bullet.new(root, {
//     sprite: container
//   })
// })


// Set data
// var data = [{
//   date: new Date(2022, 4, 01).getTime(),
//   value: 50,
//   bulletSettings: {
//     visible: false
//   }
// }, {
//   date: new Date(2022, 4, 02).getTime(),
//   value: 53,
//   bulletSettings: {
//     visible: false
//   }
// }, {
//   date: new Date(2022, 4, 03).getTime(),
//   value: 56,
//   bulletSettings: {
//     visible: false
//   }
// }, {
//   date: new Date(2022, 4, 04).getTime(),
//   value: 52,
//   bulletSettings: {
//     visible: false
//   }
// }, {
//   date: new Date(2022, 4, 05).getTime(),
//   value: 48,
//   bulletSettings: {
//     visible: false
//   }
// }, {
//   date: new Date(2022, 4, 06).getTime(),
//   value: 47,
//   bulletSettings: {
//     visible: false
//   }
// }, {
//   date: new Date(2022, 4, 07).getTime(),
//   value: 59,
//   bulletSettings: {
//     visible: true
//   }
// }]
var from = "04-01-2022";
var numbers = from.match(/\d+/g);
var date = new Date(numbers[2], numbers[0] - 1, numbers[1]);
date.setHours(0, 0, 0, 0);
var value = 100;

// #3
function generateData() {
  value = Math.round((Math.random() * 10 - 5) + value);
  am5.time.add(date, "day", 1);
  return {
    date: date.getTime(),
    value: value
  };
}

// #2
function generateDatas(count) {
  var data = [];
  for (var i = 0; i < count; ++i) {
    data.push(generateData());
  }
  return data;
}

// #1
var data = generateDatas(7);
series.data.setAll(data);

series.appear(1000);
chart.appear(1000, 100);