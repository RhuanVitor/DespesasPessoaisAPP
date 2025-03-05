import 'package:flutter/material.dart';

class Chartbar extends StatelessWidget{

  final String label;
  final double value;
  final double percentage;

  Chartbar({required this.label, required this.value, required this.percentage});

  @override
  Widget build (BuildContext context){
    return LayoutBuilder(
      builder: (ctx, constraints){
        return Column(
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.10,
            child: FittedBox(
              child: Text(value.toStringAsFixed(2))
              ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(2)
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(2)
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(
            height: constraints.maxHeight * 0.10,
            child: FittedBox(
              child: Text(label)
            )
          )
        ],
      );
      }
    );
  }
}