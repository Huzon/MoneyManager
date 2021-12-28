import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    @required Key key,
    @required this.transaction,
    @required this.dltTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function dltTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const availableColors = [Colors.red, Colors.yellow, Colors.blue];
    randomColor = availableColors[Random().nextInt(4)];
  }

  Color randomColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).accentColor,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: randomColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                "\$ ${widget.transaction.amount.toStringAsFixed(2)}",
              ),
            ),
          ),
        ),
        title: Text(
          '${widget.transaction.title}',
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMd().format(widget.transaction.date),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.dltTx(widget.transaction.id),
        ),
      ),
    );
  }
}
