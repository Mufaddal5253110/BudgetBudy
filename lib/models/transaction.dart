import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../DBhelp/dbhelper.dart';

class Transaction {
  final String id;
  final String title;
  final int amount;
  final DateTime date;
  final String category;

  const Transaction(
      {this.id, this.title, this.amount, this.date, this.category});

  Map<String, dynamic> toMap(Transaction t) {
    return {
      'id': t.id,
      'title': t.title,
      'amount': t.amount,
      'date': t.date.toIso8601String(),
      'category': t.category,
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
            category: item['category'],
          ),
        )
        .toList();
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  void deleteTransaction(String id) {
    final item = _transactions.firstWhere((item) => item.id == id);
    _transactions.remove(item);
    notifyListeners();
    DBHelper.delete(id);
  }

  List<Map<String, Object>> firstSixMonthsTransValues(
      List<Transaction> trans, int year) {
    return List.generate(6, (index) {
      List<int> months = [
        DateTime.january,
        DateTime.february,
        DateTime.march,
        DateTime.april,
        DateTime.may,
        DateTime.june,
      ];
      List<String> monthsTitle = [
        'january',
        'february',
        'march',
        'april',
        'may',
        'june',
      ];
      final perMonth = months[index];
      final perMonthTitle = monthsTitle[index];
      var totalSum = 0;
      for (var i = 0; i < trans.length; i++) {
        if (trans[i].date.month == perMonth && trans[i].date.year == year) {
          totalSum += trans[i].amount;
        }
      }

      return {
        'amount': totalSum.toDouble(),
        'month': perMonthTitle,
      };
    });
  }

  List<Map<String, Object>> lastSixMonthsTransValues(
      List<Transaction> trans, int year) {
    return List.generate(6, (index) {
      List<int> months = [
        DateTime.july,
        DateTime.august,
        DateTime.september,
        DateTime.october,
        DateTime.november,
        DateTime.december,
      ];
      List<String> monthsTitle = [
        'july',
        'august',
        'september',
        'october',
        'november',
        'december',
      ];
      final perMonth = months[index];
      final perMonthTitle = monthsTitle[index];
      var totalSum = 0;
      for (var i = 0; i < trans.length; i++) {
        if (trans[i].date.month == perMonth && trans[i].date.year == year) {
          totalSum += trans[i].amount;
        }
      }

      return {
        'amount': totalSum.toDouble(),
        'month': perMonthTitle,
      };
    });
  }
}
