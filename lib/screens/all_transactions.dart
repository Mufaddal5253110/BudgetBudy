import 'package:daily_spending/models/transaction.dart';
import 'package:daily_spending/widgets/no_trancaction.dart';
import 'package:daily_spending/widgets/transaction_list_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllTransactions extends StatefulWidget {
  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  @override
  Widget build(BuildContext context) {
    // final appBody = SafeArea(
    //   child: ListView(
    //     //crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //       Container(
    //         //width: double.infinity,
    //         height: (mQ.size.height -
    //                 appBar.preferredSize.height -
    //                 mQ.padding.top) *
    //             0.25,
    //         child: Consumer<Transactions>(builder: (context, transactions, _) {
    //           return Chart(transactions.rescentTransactions);
    //         }),
    //       ),
    //       Container(
    //           height: (mQ.size.height -
    //                   appBar.preferredSize.height -
    //                   mQ.padding.top) *
    //               0.75,
    //           child: TransactionList()),
    //     ],
    //   ),
    // );

    final deleteFn =
        Provider.of<Transactions>(context, listen: false).deleteTransaction;
    return FutureBuilder(
      future:
          Provider.of<Transactions>(context, listen: false).fetchTransactions(),
      builder: (ctx, snapshot) =>
          (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : Consumer<Transactions>(
                  child: NoTransactions(),
                  builder: (context, transactions, child) {
                    return (transactions.transactions.length == 0)
                        ? child
                        : ListView.builder(
                            itemBuilder: (ctx, index) {
                              return TransactionListItems(
                                  trx: transactions.transactions[index],
                                  dltTrxItem: deleteFn);
                            },
                            itemCount: transactions.transactions.length,
                          );
                  },
                ),
    );
  }
}

// Card(
//                             margin: EdgeInsets.symmetric(
//                                 horizontal: 5, vertical: 8),
//                             elevation: 5,
//                             child: ListTile(
//                               leading: CircleAvatar(
//                                   radius: 30,
//                                   child: Padding(
//                                     padding: EdgeInsets.all(6),
//                                     child: FittedBox(
//                                         child: Text(
//                                             '\₹${transactions.transactions[index].amount}')),
//                                   )),
//                               title: Text(
//                                 transactions.transactions[index].title,
//                                 style: Theme.of(context).textTheme.headline1,
//                               ),
//                               subtitle: Text(DateFormat.yMMMd().format(
//                                   transactions.transactions[index].date)),
//                               trailing: IconButton(
//                                 icon: Icon(Icons.delete,color: Theme.of(context).errorColor,),
//                                 onPressed: () => showDialog(
//                                   context: ctx,
//                                   barrierDismissible: false,
//                                   builder: (context) => AlertDialog(
//                                     title: Text('Are you sure'),
//                                     content: Text(
//                                         'Do you really want to delete this transaction?'),
//                                     actions: [
//                                       FlatButton(
//                                           onPressed: () {
//                                             deleteFn(transactions
//                                                 .transactions[index].id);
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text(
//                                             'Yes',
//                                             style: TextStyle(
//                                                 fontSize: 20,
//                                                 color: Theme.of(context)
//                                                     .primaryColor),
//                                           )),
//                                       FlatButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text(
//                                             'No',
//                                             style: TextStyle(fontSize: 20),
//                                           ))
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
