import 'package:daily_spending/models/pie_data.dart';
import 'package:daily_spending/models/transaction.dart';
import 'package:daily_spending/screens/statistics/pie_chart.dart';
import 'package:daily_spending/widgets/no_trancaction.dart';
import 'package:daily_spending/widgets/transaction_list_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DailySpendings extends StatefulWidget {
  @override
  _DailySpendingsState createState() => _DailySpendingsState();
}

class _DailySpendingsState extends State<DailySpendings> {
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final trxData = Provider.of<Transactions>(context, listen: false);

    final deleteFn =
        Provider.of<Transactions>(context, listen: false).deleteTransaction;

    final dailyTrans = Provider.of<Transactions>(context).dailyTransactions();

    final List<PieData> dailyData = PieData().pieChartData(dailyTrans);

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              padding:
                  EdgeInsets.only(right: 15, top: 10, bottom: 10, left: 15),
              color: Theme.of(context).primaryColorLight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
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
          dailyTrans.isEmpty
              ? NoTransactions()
              : (_showChart
                  ? MyPieChart(pieData: dailyData)
                  : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    return TransactionListItems(
                        trx: dailyTrans[index], dltTrxItem: deleteFn);
                  },
                  itemCount: dailyTrans.length,
                ))
        ],
      ),
    );
  }
}