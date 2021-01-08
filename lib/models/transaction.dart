import 'package:flutter/foundation.dart';

import '../DBhelp/dbhelper.dart';

class Transaction {
  final String id;
  final String title;
  final int amount;
  final DateTime date;

  Transaction({this.id, this.title, this.amount, this.date});

  Map<String, dynamic> toMap(Transaction t) {
    return {
      'id': t.id,
      'title': t.title,
      'amount': t.amount,
      'date': t.date.toIso8601String(),
    };
  }
}

class Transactions with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions {
    return [..._transactions];
  }

  int getTotal() {
    var total = 0;
    _transactions.forEach((item) {
      total += item.amount;
    });
    return total;
  }

  void addTransactions(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
    DBHelper.insert(transaction);
  }

  // List<Transaction> get monthlyTransactions(String month) {
  //   return transactions.where((tx) {
  //     return tx.date.isAfter(DateTime.now().subtract(
  //       Duration(days: 7),
  //     ));
  //   }).toList();
  // }

  List<Transaction> get rescentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  Future<void> fetchTransactions() async {
    final fetchedData = await DBHelper.fetch();
    _transactions = fetchedData
        .map(
          (item) => Transaction(
            id: item['id'],
            title: item['title'],
            amount: item['amount'],
            date: DateTime.parse(
              item['date'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  void deleteTransaction(String id) {
    final item = _transactions.firstWhere((item) => item.id == id);
    _transactions.remove(item);
    notifyListeners();
    DBHelper.delete(id);
  }
}
