import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:daily_spending/models/pie_data.dart';
import 'package:daily_spending/models/transaction.dart';
import 'package:daily_spending/screens/statistics/pie_chart.dart';
import 'package:daily_spending/screens/statistics/weekly_stats.dart';
import 'package:daily_spending/widgets/no_trancaction.dart';
import 'package:daily_spending/widgets/transaction_list_items.dart';

class WeeklySpendings extends StatefulWidget {
  @override
  _WeeklySpendingsState createState() => _WeeklySpendingsState();
}

class _WeeklySpendingsState extends State<WeeklySpendings> {
  bool _showChart = false;
  Transactions trxData;
  // List<Transaction> recentTransaction;
  // List<PieData> recentData;
  // Function deleteFn;

  @override
  void initState() {
    super.initState();

    trxData = Provider.of<Transactions>(context, listen: false);
    // recentTransaction =
    //     Provider.of<Transactions>(context, listen: false).rescentTransactions;

    // deleteFn =
    //     Provider.of<Transactions>(context, listen: false).deleteTransaction;

    // recentData = PieData().pieChartData(recentTransaction);
  }

  @override
  Widget build(BuildContext context) {
    final deleteFn =
        Provider.of<Transactions>(context).deleteTransaction;
    final recentTransaction =
        Provider.of<Transactions>(context, listen: false).rescentTransactions;
    final recentData = PieData().pieChartData(recentTransaction);
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(
                  right: 15, top: 10, bottom: 10, left: 15),
              color: Theme.of(context).primaryColorLight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "₹${trxData.getTotal(recentTransaction)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Show Chart',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Switch.adaptive(
                        activeColor: Theme.of(context).accentColor,
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )),
          recentTransaction.isEmpty
              ? NoTransactions()
              : (_showChart
                  ? weaklyChart(context, recentTransaction, recentData)
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return TransactionListItems(
                            trx: recentTransaction[index],
                            dltTrxItem: deleteFn);
                      },
                      itemCount: recentTransaction.length,
                    ))
        ],
      ),
    );
  }

  Column weaklyChart(
    BuildContext context,
    List<Transaction> recentTransaction,
    List<PieData> recentData,
  ) {
    return Column(
      children: [
        Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          color: Theme.of(context).primaryColorDark,
          child: MyPieChart(pieData: recentData),
        ),
        WeaklyStats(
          rescentTransactions: recentTransaction,
        )
      ],
    );
  }
}
