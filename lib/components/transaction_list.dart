import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget{

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList({required this.transactions, required this.onRemove});

  @override
  Widget build(BuildContext context){
    return Container(
      height: 480,
      child: transactions.isEmpty ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Nenhuma transação cadastrada"),
          SizedBox(height: 25),
          SizedBox(
            height: 100,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      ) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index){
        final tr = transactions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: FittedBox(
                  child: Text(
                    'R\$ ${tr.value}',
                  ),
                ),
              ),
            ),
            title: Text(
              tr.title,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text(
              DateFormat('d MMM y').format(tr.date)
            ),
            trailing: IconButton(
              onPressed: () => onRemove(tr.id), 
              icon: Icon(Icons.delete),
              color: Colors.redAccent,
            ),
          ),
        );
        }
      )
    );
  }
}