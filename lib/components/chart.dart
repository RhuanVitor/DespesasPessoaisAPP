import 'package:despesas/components/chartBar.dart';
import 'package:despesas/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget{

  late final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  double get _weekTotalValue{
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + (tr['value'] as double);
    });
  }

  List<Map<String, Object>> get groupedTransactions{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (int i = 0; i < recentTransactions.length; i++){
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;
        if (sameDay && sameMonth && sameYear){
          totalSum += recentTransactions[i].value;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0], 
        'value': totalSum
      };
    }).reversed.toList();
  }

  @override
  Widget build (BuildContext context){
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: Chartbar(
                label: tr['day'].toString(), 
                value: (tr['value'] as double), 
                percentage: _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}