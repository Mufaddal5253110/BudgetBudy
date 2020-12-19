import '../widgets/transaction_list_items.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTransaction;

  TransactionList(this.transaction, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Column(children: <Widget>[
            Text(
              "No transaction added yet!",
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            )
          ])
        : ListView(
            children: transaction
                .map(
                  (transaction) => TransactionListItems(
                    key: ValueKey(transaction.id),
                    dltTrxItem: deleteTransaction,
                    trx: transaction,
                  ),
                )
                .toList(),
          );
  }
}
