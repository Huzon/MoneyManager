import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);
//list of transactions for 1 day
  List<Map<String, Object>> get groupedTransValues {
    return List.generate(7, (index) {
      double totalSpending = 0;
      final weekday = DateTime.now().subtract(Duration(days: index));

      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.weekday == weekday.weekday &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          totalSpending += recentTransaction[i].amount;
        }
      }
      print('amount : $totalSpending');
      print(DateFormat.E().format(weekday));
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSpending
      };
    }).reversed.toList();
  }

  //using fold to get total of amount of a day
  double get maxSpending {
    return groupedTransValues.fold(0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransValues);
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: data['day'],
                    spendingAmt: data['amount'],
                    spendingPercent: maxSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / maxSpending),
              );
            }).toList()),
      ),
    );
  }
}
