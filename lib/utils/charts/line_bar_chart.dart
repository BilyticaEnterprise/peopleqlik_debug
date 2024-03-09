import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../../../../configs/colors.dart';
import '../../../../../../../configs/fonts.dart';
import '../../../../../../../utils/screen_sizes.dart';

class _BarChart extends StatelessWidget {
  final double total;
  final List<LineBarChartData> data;
  late BuildContext context;
  _BarChart(this.data, this.total);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: getBarGroups(),
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: total,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: ScreenSize(context).heightOnly(1.2),
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          GetFont.get(
              context,
              color: MyColor.colorBlack,
              fontWeight: FontWeight.bold,
              fontSize: 1.4
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    var style = GetFont.get(
      context,
      color: MyColor.colorBlack,
      fontWeight: FontWeight.w600,
      fontSize: 1.2,
    );
    String text;
    text = data[value.toInt()].bottomText;
    // switch (value.toInt()) {
    //   case 0:
    //     text = 'On-T';
    //     break;
    //   case 1:
    //     text = 'Late';
    //     break;
    //   case 2:
    //     text = 'E-Out';
    //     break;
    //   case 3:
    //     text = 'Miss';
    //     break;
    //   case 4:
    //     text = 'Others';
    //     break;
    //   case 5:
    //     text = 'Leave';
    //     break;
    //   case 6:
    //     text = 'Absent';
    //     break;
    //   default:
    //     text = '';
    //     break;
    // }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: ScreenSize(context).heightOnly(1.6),
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: ScreenSize(context).heightOnly(4),
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  LinearGradient get _barsGradient => const LinearGradient(
    colors: [
      Color(MyColor.colorA5),
      Color(MyColor.colorA5),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> getBarGroups()
  {
    List<BarChartGroupData> list = List.empty(growable: true);
    for(int x=0;x<data.length;x++)
    {
      list.add(
          BarChartGroupData(
            x: x,
            barRods: [
              BarChartRodData(
                toY: data[x].value,
                width: ScreenSize(context).widthOnly(4.4),
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          )
      );
    }
    return list;
  }

// List<BarChartGroupData> get barGroups => [
//   BarChartGroupData(
//     x: 0,
//     barRods: [
//       BarChartRodData(
//         toY: 8,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 1,
//     barRods: [
//       BarChartRodData(
//         toY: 10,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 2,
//     barRods: [
//       BarChartRodData(
//         toY: 24,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 3,
//     barRods: [
//       BarChartRodData(
//         toY: 15,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 4,
//     barRods: [
//       BarChartRodData(
//         toY: 13,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 5,
//     barRods: [
//       BarChartRodData(
//         toY: 13,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
//   BarChartGroupData(
//     x: 6,
//     barRods: [
//       BarChartRodData(
//         toY: 13,
//         gradient: _barsGradient,
//       )
//     ],
//     showingTooltipIndicators: [0],
//   ),
// ];
}


class LineBarChart extends StatefulWidget {
  final List<LineBarChartData> data;
  final double total;
  final String date;
  const LineBarChart({required this.data,required this.total,required this.date,super.key});

  @override
  State<StatefulWidget> createState() => LineBarChartState();
}

class LineBarChartState extends State<LineBarChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 2.0,
        child: _BarChart(widget.data,widget.total)
    );
  }
}

class LineBarChartData
{
  double value;
  String bottomText;
  LineBarChartData({required this.value,required this.bottomText});
}