import 'package:firstapp1/components/chart.dart';
import 'package:firstapp1/components/transaction_form.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Despesas pessoais", 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
          ),
        actions: [
          IconButton(
          onPressed: () => {_openTransactionFormModal(context)}, 
          icon: Icon(Icons.add, color: Colors.white,),
          )
        ], 
        backgroundColor: Theme.of(context).primaryColor,
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chart(_recentTransactions),
          TransactionList(transactions: _transactions, onRemove: _deleteTransaction,),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => {_openTransactionFormModal(context)}, child: Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}