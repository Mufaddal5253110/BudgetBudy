import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:daily_spending/models/transaction.dart';

class WeeklyStats extends StatefulWidget {
  final List<Transaction> rescentTransactions;

  WeeklyStats({
    Key key,
    this.rescentTransactions,
  }) : super(key: key);

  @override
  _WeeklyStatsState createState() => _WeeklyStatsState();
}

class _WeeklyStatsState extends State<WeeklyStats> {
  // final List<double> weeklyData = [5.0, 6.5, 5.0, 7.5, 9.0, 11.5, 6.5];

  int touchedIndex;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0;
      for (var i = 0; i < widget.rescentTransactions.length; i++) {
        if (widget.rescentTransactions[i].date.day == weekDay.day &&
            widget.rescentTransactions[i].date.month == weekDay.month &&
            widget.rescentTransactions[i].date.year == weekDay.year) {
          totalSum += widget.rescentTransactions[i].amount;
        }
      }

      /*print(DateFormat.E().format(weekDay));
      print(totalSum);*/

      return {
        'day': DateFormat.EEEE() .format(weekDay), //.substring(0, 1),
        'amount': totalSum.toDouble(),
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            color: Theme.of(context).primaryColorDark,//Color(0xff81e5cd),
          ),
          margin: EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Analysis',
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight,//Color(0xff0f4a3c),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Last Seven Days',
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight,//const Color(0xff379982),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BarChart(
                    mainBarData(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BarChartGroupData _buildBar(
    int x,
    double y, {
    bool isTouched = false,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: y,
          colors: isTouched ? [Theme.of(context).primaryColor] : [Colors.white],
          width: 22,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [Theme.of(context).primaryColorLight],//[Color(0xff72d8bf)],
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildAllBars() {
    return List.generate(
      groupedTransactionValues.length,
      (index) =>
          _buildBar(index, groupedTransactionValues[index]['amount'], isTouched: index == touchedIndex),
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: _buildBarTouchData(),
      titlesData: _buildAxes(),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: _buildAllBars(),
    );
  }

  FlTitlesData _buildAxes() {
    return FlTitlesData(
      // Build X axis.
      bottomTitles: SideTitles(
        showTitles: true,
        getTextStyles: (value) => const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        margin: 16,
        getTitles: (double value) {
          switch (value.toInt()) {
            case 0:
              return groupedTransactionValues[0]['day'].toString().substring(0,3);
            case 1:
              return groupedTransactionValues[1]['day'].toString().substring(0,3);
            case 2:
              return groupedTransactionValues[2]['day'].toString().substring(0,3);
            case 3:
              return groupedTransactionValues[3]['day'].toString().substring(0,3);
            case 4:
              return groupedTransactionValues[4]['day'].toString().substring(0,3);
            case 5:
              return groupedTransactionValues[5]['day'].toString().substring(0,3);
            case 6:
              return groupedTransactionValues[6]['day'].toString().substring(0,3);
            default:
              return '';
          }
        },
      ),
      // Build Y axis.
      leftTitles: SideTitles(
        showTitles: false,
        getTitles: (double value) {
          return value.toString();
        },
      ),
    );
  }

  BarTouchData _buildBarTouchData() {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.blueGrey,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          String weekDay;
          switch (group.x.toInt()) {
            case 0:
              weekDay = groupedTransactionValues[0]['day'];
              break;
            case 1:
              weekDay = groupedTransactionValues[1]['day'];
              break;
            case 2:
              weekDay = groupedTransactionValues[2]['day'];
              break;
            case 3:
              weekDay = groupedTransactionValues[3]['day'];
              break;
            case 4:
              weekDay = groupedTransactionValues[4]['day'];
              break;
            case 5:
              weekDay = groupedTransactionValues[5]['day'];
              break;
            case 6:
              weekDay = groupedTransactionValues[6]['day'];
              break;
          }
          return BarTooltipItem(
            weekDay + '\n' + (rod.y).toString(),
            TextStyle(color: Colors.yellow),
          );
        },
      ),
      touchCallback: (barTouchResponse) {
        setState(() {
          if (barTouchResponse.spot != null &&
              barTouchResponse.touchInput is! FlPanEnd &&
              barTouchResponse.touchInput is! FlLongPressEnd) {
            touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
          } else {
            touchedIndex = -1;
          }
        });
      },
    );
  }
}
