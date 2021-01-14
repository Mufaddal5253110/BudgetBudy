import 'package:flutter/material.dart';

class NoTransactions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          // height: MediaQuery.of(context).size.height * 0.5,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'No data available!',
        ),
      ],
    );
  }
}
