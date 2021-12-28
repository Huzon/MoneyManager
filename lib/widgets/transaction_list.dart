import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import 'transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function dltTx;

  TransactionList(this.transactions, this.dltTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 450,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No transactions yet!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset('assets/images/waiting.png'),
                    ),
                  ],
                );
              })
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return TransactionItem(
                      key: UniqueKey(),
                      transaction: transactions[index],
                      dltTx: dltTx);
                }));
  }
}
