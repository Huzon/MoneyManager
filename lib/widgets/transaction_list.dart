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
            : ListView(
                children: transactions
                    .map((trnx) => TransactionItem(
                        key: ValueKey(trnx.id),
                        transaction: trnx,
                        dltTx: dltTx))
                    .toList(),
              ));
  }
}
