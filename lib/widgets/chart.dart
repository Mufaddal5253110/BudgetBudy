import 'package:daily_spending/models/transaction.dart';
import 'package:daily_spending/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transaction;

  Chart(this.transaction);

  List<Map<String, Object>> get groupOfTransactions {
    return List.generate(7, (index) {
      double totalAmount = 0.0;

      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      for (var tx in transaction) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalAmount += tx.amount;
        }
      }

      // print(DateFormat.E().format(weekDay));
      return {'day': DateFormat.E().format(weekDay), 'amount': totalAmount};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupOfTransactions.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount']);
    });
  }

  double percentage(amount) {
    if (totalSpending == 0.0) {
      return 0.0;
    } else {
      return amount / totalSpending;
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(groupOfTransactions);
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupOfTransactions.map((data) {
            return Expanded(
              //fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                amountSpend: data['amount'],
                spendingPer: percentage(data['amount'] as double),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
