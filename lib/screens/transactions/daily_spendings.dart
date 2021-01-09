import 'package:daily_spending/models/transaction.dart';
import 'package:daily_spending/widgets/no_trancaction.dart';
import 'package:daily_spending/widgets/transaction_list_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailySpendings extends StatefulWidget {
  @override
  _DailySpendingsState createState() => _DailySpendingsState();
}

class _DailySpendingsState extends State<DailySpendings> {
  @override
  Widget build(BuildContext context) {
    final trxData = Provider.of<Transactions>(context, listen: false);

    final deleteFn =
        Provider.of<Transactions>(context, listen: false).deleteTransaction;
    final dailyTrans = Provider.of<Transactions>(context).dailyTransactions();

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 15, top: 10, bottom: 10, left: 15),
            color: Theme.of(context).primaryColorLight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "₹${trxData.getTotal(dailyTrans)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          dailyTrans.isEmpty
              ? NoTransactions()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return TransactionListItems(
                        trx: dailyTrans[index], dltTrxItem: deleteFn);
                  },
                  itemCount: dailyTrans.length,
                ),
        ],
      ),
    );
  }
}
