import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

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

  int getTotal(List<Transaction> transaction) {
    var total = 0;
    if (transaction.isEmpty) {
      return total;
    }
    transaction.forEach((item) {
      total += item.amount;
    });
    return total;
  }

  void addTransactions(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
    DBHelper.insert(transaction);
  }

  List<Transaction> monthlyTransactions(String month, String year) {
    return _transactions.where((trx) {
      if (DateFormat('yyyy')
                  .format(DateTime.parse(trx.date.toIso8601String())) ==
              year &&
          DateFormat('MMM')
                  .format(DateTime.parse(trx.date.toIso8601String())) ==
              month) {
        return true;
      }
      return false;
    }).toList();
  }

  List<Transaction> yearlyTransactions(String year) {
    return _transactions.where((trx) {
      if (DateFormat('yyyy')
              .format(DateTime.parse(trx.date.toIso8601String())) ==
          year) {
        return true;
      }
      return false;
    }).toList();
  }

  List<Transaction> dailyTransactions() {
    return _transactions.where((trx) {
      if (DateTime.now().day ==
              DateTime.parse(trx.date.toIso8601String()).day &&
          DateTime.now().month ==
              DateTime.parse(trx.date.toIso8601String()).month &&
          DateTime.now().year ==
              DateTime.parse(trx.date.toIso8601String()).year) {
        return true;
      }
      return false;
    }).toList();
  }

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
