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
      child: transactions.isEmpty ? LayoutBuilder(
        builder: (ctx, constraints){
          return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Nenhuma transação cadastrada"),
          SizedBox(height: 25),
          SizedBox(
            height: constraints.maxHeight * 0.2,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.3)
        ],
        ); 
        }
      )
      : 
      ListView.builder(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
        itemCount: transactions.length,
        itemBuilder: (ctx, index){
        final tr = transactions[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent.withAlpha(100),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: FittedBox(
                  child: Text(
                    'R\$ ${tr.value}',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 61, 30, 114),
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                    ),
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
            trailing: MediaQuery.of(context).size.width > 480 ? 
            TextButton.icon(
              onPressed: () => onRemove(tr.id),
              icon: Icon(
                Icons.delete, 
                color: Colors.redAccent,
                size: 20,
              ),
              label: Text(
                "excluir",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 15,
                ),
              ),
            )
             : 
            IconButton(
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