import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:moneymanager/widgets/user_transaction.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final amountController = TextEditingController();

  final titleController = TextEditingController();
  DateTime _selectedDate;

  void submitTnx() {
    //to submit the added values
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return;
    } else {
      widget.addTx(
        enteredTitle,
        enteredAmount,
        _selectedDate,
      );

      Navigator.of(context).pop();
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) return;
      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  //onChanged: (val) => title=val,
                  controller: titleController,
                  onSubmitted: (_) => submitTnx(),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  onSubmitted: (_) => submitTnx(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? "No date picked"
                              : "Date picked ${DateFormat.yMd().format(_selectedDate)}",
                        ),
                      ),
                      TextButton(
                        onPressed: _presentDatePicker,
                        style: TextButton.styleFrom(
                            textStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                        child: Text(
                          "Pick a date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: submitTnx,
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(
                          color: Theme.of(context).textTheme.button.color),
                      primary: Theme.of(context).primaryColor),
                  child: Text(
                    'Add Transaction',
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
