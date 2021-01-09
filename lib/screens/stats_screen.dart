import 'package:daily_spending/models/transaction.dart';
import 'package:daily_spending/widgets/app_drawer.dart';
import 'package:daily_spending/screens/statistics/weekly_stats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatsScreen extends StatefulWidget {
  static const routeName = '/stats';
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<Transaction> recentTransaction;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(initialIndex: 0, length: 1, vsync: this);
    recentTransaction = Provider.of<Transactions>(context,listen: false).rescentTransactions;
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Statistics",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        bottom: new TabBar(
          tabs: <Widget>[
            new Tab(
              text: 'Weakly',
            ),
          ],
          controller: tabController,
        ),
      ),
      body: new TabBarView(
        children: <Widget>[
          new WeeklyStats(rescentTransactions: recentTransaction,),
        ],
        controller: tabController,
      ),
      drawer: AppDrawer(),
    );
  }
}
