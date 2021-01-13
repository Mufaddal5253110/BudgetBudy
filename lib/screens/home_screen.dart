import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/transaction.dart';
import './transactions/daily_spendings.dart';
import './transactions/monthly_spendings.dart';
import './transactions/yearly_spendings.dart';
import '../widgets/app_drawer.dart';
import './new_transaction.dart';
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
      body: FutureBuilder(
        future: Provider.of<Transactions>(context, listen: false)
            .fetchTransactions(),
        builder: (ctx, snapshot) =>
            (snapshot.connectionState == ConnectionState.waiting)
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
                    children: <Widget>[
                      new DailySpendings(),
                      new WeaklySpendings(),
                      new MonthlySpendings(),
                      new YearlySpendings(),
                    ],
                    controller: tabController,
                  ),
      ),
      drawer: Consumer<Transactions>(
        builder: (context, trx, child) {
          return AppDrawer(total: trx.getTotal(trx.transactions));
        },
      ),
    );
  }
}
