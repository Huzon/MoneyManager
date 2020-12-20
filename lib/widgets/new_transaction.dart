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

  void submitTnx() { //to submit the added values
    if(amountController.text.isEmpty){
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate==null) {
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

  void _presentDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2019), 
      lastDate: DateTime.now(),
      ).then((datePicked){
        if(datePicked == null)
          return;
        setState(() {
          _selectedDate = datePicked;
        });
      });
  } 

  

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
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
                      child: Text(_selectedDate==null?
                      "No date picked":
                      "Date picked ${DateFormat.yMd().format(_selectedDate)}",
                      ),
                    ),
                    FlatButton(
                      onPressed: _presentDatePicker,
                      textColor: Theme.of(context).primaryColor, 
                      child: Text(
                        "Pick a date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitTnx,
                child: Text(
                  'Add Transaction',
                ),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
              ),
            ]),
      ),
    );
  }
}
