import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/transactions_list.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Spending',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
              ),
              button:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> allTransaction = [
    Transaction(
      id: 't1',
      title: 'New Dress',
      amount: 600,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New ball',
      amount: 60,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New Dress',
      amount: 600,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'New ball',
      amount: 60,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get lastWeakTransaction {
    return allTransaction.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      allTransaction.removeWhere((element) => element.id == id);
    });
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        title: title, amount: amount, date: date, id: date.toString());
    setState(() {
      allTransaction.add(newTx);
    });
  }

  void _startToAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            middle: Text("Daily Spending"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: IconButton(
                    icon: Icon(CupertinoIcons.add),
                    onPressed: () => _startToAddNewTransaction(context),
                  ),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text("Daily Spending"),
          );

    final appBody = SafeArea(
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            //width: double.infinity,
            height: (mQ.size.height -
                    appBar.preferredSize.height -
                    mQ.padding.top) *
                0.25,
            child: Chart(lastWeakTransaction),
          ),
          Container(
              height: (mQ.size.height -
                      appBar.preferredSize.height -
                      mQ.padding.top) *
                  0.75,
              child: TransactionList(allTransaction, _deleteTransaction)),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: appBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: appBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startToAddNewTransaction(context),
                  ),
          );
  }
}
