import 'package:daily_spending/models/transaction.dart';
import 'package:daily_spending/screens/transactions/daily_spendings.dart';
import 'package:daily_spending/screens/transactions/monthly_spendings.dart';
import 'package:daily_spending/screens/transactions/yearly_spendings.dart';
import 'package:daily_spending/widgets/app_drawer.dart';
import 'package:daily_spending/screens/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './transactions/weakly_spendings.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(initialIndex: 0, length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  // void _startToAddNewTransaction(BuildContext ctx) {
  //   // showBottomSheet(
  //   //   context: ctx,
  //   //   builder: (ctx) => NewTransaction(),
  //   // );

  //   showModalBottomSheet(
  //       context: ctx,
  //       builder: (_) {
  //         return NewTransaction();
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () =>
                  Navigator.of(context).pushNamed(NewTransaction.routeName)),
        ],
        bottom: new TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          indicatorColor: Theme.of(context).primaryColorDark,
          tabs: <Widget>[
            new Tab(
              text: "Daily",
            ),
            new Tab(
              text: "Weakly",
            ),
            new Tab(
              text: 'Monthly',
            ),
            new Tab(
              text: 'Yearly',
            ),
          ],
          controller: tabController,
        ),
      ),
      body: new TabBarView(
        children: <Widget>[
          new DailySpendings(),
          new WeaklySpendings(),
          new MonthlySpendings(),
          new YearlySpendings(),
        ],
        controller: tabController,
      ),
      drawer: Consumer<Transactions>(
        builder: (context, trx, child) {
          return AppDrawer(total: trx.getTotal(trx.transactions));
        },
      ),
    );
  }
}
