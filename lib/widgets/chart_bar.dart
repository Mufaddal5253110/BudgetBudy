import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amountSpend;
  final double spendingPer;

  ChartBar({this.label, this.amountSpend, this.spendingPer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 18,
          child: FittedBox(
            child: Text('₹$amountSpend'),
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPer,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5),
        Text(label)
      ],
    );
  }
}
