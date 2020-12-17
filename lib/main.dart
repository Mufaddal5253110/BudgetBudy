import 'package:daily_spending/widgets/chart.dart';

import './widgets/transactions_list.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';

void main() {
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

  void _deleteTransaction(int index) {
    setState(() {
      allTransaction.removeAt(index);
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Spending"),
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Chart(lastWeakTransaction),
          ),
          TransactionList(allTransaction , _deleteTransaction),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startToAddNewTransaction(context),
      ),
    );
  }
}
