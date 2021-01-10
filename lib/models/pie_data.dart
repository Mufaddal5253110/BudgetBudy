import 'package:daily_spending/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class PieData {
  final String name;
  final double percent;
  final Color color;
  final int price;

  PieData({
    this.name,
    this.percent,
    this.color,
    this.price,
  });

  List<PieData> pieChartData(List<Transaction> trx) {
    int total = Transactions().getTotal(trx);
    // print(total);
    RandomColor _randomColor = RandomColor();

    List<PieData> data = [];

    trx.forEach((transEelement) {
      Color _color =
          _randomColor.randomColor(colorBrightness: ColorBrightness.primary);
      data.add(PieData(
        name: transEelement.title,
        percent: ((transEelement.amount * 100) / total).round().ceilToDouble(),
        color: _color,
        price: transEelement.amount
      ));
    });

    return data;
  }
}
