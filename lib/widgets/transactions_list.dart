import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTransaction;

  TransactionList(this.transaction, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height,
      height: 300,
      child: transaction.isEmpty
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
          : ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (context, index) {
                return Card(
                    elevation: 5,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          padding: EdgeInsets.all(8.0),
                          child: Text("₹${transaction[index].amount}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark,
                              )),
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${transaction[index].title}",
                              style: Theme.of(context).textTheme.title,
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(transaction[index].date),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            )
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  deleteTransaction(index);
                                },
                                color: Theme.of(context).errorColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
              },
            ),
    );
  }
}
