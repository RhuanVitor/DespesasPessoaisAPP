import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget{
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm({required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm(){
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0){
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
        return ;
      }

      setState(() {
              _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build (BuildContext context){
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: 
          Column(
            children: [
              TextField(
                controller: titleController,
                onSubmitted: (value) => _submitForm(),
                decoration: InputDecoration(
                  label: Text("Título")
                ),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: valueController,
                onSubmitted: (value) => _submitForm(),
                decoration: InputDecoration(
                  label: Text("Valor (R\$)")
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Text(
                      DateFormat('dd/MM/y').format(_selectedDate)
                    ),
                    TextButton(
                      onPressed: _showDatePicker, 
                      child: Text(
                        "Selecionar data",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _submitForm, 
                    child: Text("Nova transação"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
      ),
    );
  }
}