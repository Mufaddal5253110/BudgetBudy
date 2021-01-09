import 'package:daily_spending/models/transaction.dart';
import 'package:daily_spending/widgets/no_trancaction.dart';
import 'package:daily_spending/widgets/transaction_list_items.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class YearlySpendings extends StatefulWidget {
  @override
  _YearlySpendingsState createState() => _YearlySpendingsState();
}

class _YearlySpendingsState extends State<YearlySpendings> {
  String _selectedYear = DateFormat('yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final trxData = Provider.of<Transactions>(context, listen: false);

    final deleteFn =
        Provider.of<Transactions>(context, listen: false).deleteTransaction;
    final yearlyTrans =
        Provider.of<Transactions>(context).yearlyTransactions(_selectedYear);
    print(_selectedYear);

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(right: 15, left: 5, top: 5, bottom: 5),
              color: Theme.of(context).primaryColorLight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widgetToSelectYear(),
                  Text(
                    "₹${trxData.getTotal(yearlyTrans)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              )),
          yearlyTrans.isEmpty
              ? NoTransactions()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return TransactionListItems(
                        trx: yearlyTrans[index], dltTrxItem: deleteFn);
                  },
                  itemCount: yearlyTrans.length,
                ),
        ],
      ),
    );
  }

  Row widgetToSelectYear() {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: int.parse(_selectedYear) == 0
              ? null
              : () {
                  setState(() {
                    _selectedYear = (int.parse(_selectedYear) - 1).toString();
                  });
                },
        ),
        Text(_selectedYear),
        IconButton(
          icon: Icon(Icons.arrow_right),
          onPressed: _selectedYear == DateFormat('yyyy').format(DateTime.now())
              ? null
              : () {
                  setState(() {
                    _selectedYear = (int.parse(_selectedYear) + 1).toString();
                  });
                },
        ),
      ],
    );
  }
}
