import 'package:flutter/material.dart';

class FinalWidget extends StatefulWidget{
  final String name;
  final String age;
  final String group;
  final MaterialColor color;

  const FinalWidget({super.key, required this.name, required this.age , required this.group, required this.color});

  @override
  State<FinalWidget> createState() => _FinalWidgetState();
}


class _FinalWidgetState extends State<FinalWidget>{
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text("5. Конец"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("ФИО: ${widget.name}"),
            Text("Возраст: ${widget.age}"),
            Text("Группа: ${widget.group}"),
          ],
        ),
      ),
    );
  }
}