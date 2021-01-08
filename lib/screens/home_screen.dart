import 'package:daily_spending/screens/all_transactions.dart';
import 'package:daily_spending/widgets/app_drawer.dart';
import 'package:daily_spending/widgets/new_transaction.dart';
import 'package:flutter/material.dart';

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
    tabController = new TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  void _startToAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        bottom: new TabBar(
          tabs: <Widget>[
            new Tab(
              text: "Yearly",
            ),
            new Tab(
              text: 'Monthly',
            ),
          ],
          controller: tabController,
        ),
      ),
      body: new TabBarView(
        children: <Widget>[
          new AllTransactions(),
          new AllTransactions(),
        ],
        controller: tabController,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startToAddNewTransaction(context),
      ),
      drawer: AppDrawer(),
    );
  }
}
