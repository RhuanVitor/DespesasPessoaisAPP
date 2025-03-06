import 'package:despesas/components/chart.dart';
import 'package:despesas/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/transaction.dart';
import './components/transaction_list.dart';
import 'dart:math';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        fontFamily: 'roboto',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Transaction> _transactions = [



  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions{
    return _transactions.where((tr){
        return tr.date.isAfter(DateTime.now().subtract(
          Duration(days: 7)
      ));
    }).toList();
  }

  void _addTrasaction(String title, double value, DateTime date){
    Transaction newTransaction = Transaction(
      id: Random().nextDouble().toString(), 
      title: title, 
      value: value, 
      date: date
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _deleteTransaction(String id){
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id
      );
    });
  }

  _openTransactionFormModal(BuildContext context, ){
    showModalBottomSheet(
      context: context, 
      builder: (ctx){
        return TransactionForm(onSubmit: _addTrasaction);
      }
    );
  }

  @override
  Widget build (BuildContext context){
    final mediaQuery = MediaQuery.of(context); 

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
        title: Text(
          "Despesas pessoais", 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 20 * mediaQuery.textScaler.scale(1),
            fontWeight: FontWeight.bold,
            ),
          ),
        actions: [
          if (isLandscape)
          IconButton(
            onPressed: () => {
              setState(() {
                _showChart = !_showChart;
              })
            }, 
            icon: !_showChart ? Icon(Icons.bar_chart_rounded, color: Colors.white,) : Icon(Icons.list, color: Colors.white,),
          ),

          IconButton(
          onPressed: () => {_openTransactionFormModal(context)}, 
          icon: Icon(Icons.add, color: Colors.white,),
          )
        ], 
        backgroundColor: Theme.of(context).primaryColor,
        );

    final availableHeight = mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(_showChart == true || !isLandscape)
          Container(
            height: isLandscape? availableHeight * 0.75 : availableHeight * 0.3,
            child: Chart(_recentTransactions)
          ),
          if (_showChart == false || !isLandscape)
          Container(
            height: isLandscape? availableHeight * 1 : availableHeight * 0.7,
            child: TransactionList(transactions: _transactions, onRemove: _deleteTransaction,)
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => {_openTransactionFormModal(context)}, child: Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}