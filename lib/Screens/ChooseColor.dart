import 'package:flutter/material.dart';
import 'package:first_flutter_project/Screens/FInalScreen.dart';

class ChooseColor extends StatefulWidget{
  final String name;
  final String age;
  final String group;

  const ChooseColor({super.key, required this.name, required this.age, required this.group});

  @override
  State<ChooseColor> createState() => _ChooseColorState();
}

class _ChooseColorState extends State<ChooseColor>{
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("4. ${widget.group}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Выбери любимый цвет"),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed:  () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinalWidget(name: widget.name, age: widget.age, group: widget.group, color: Colors.red)));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text("Красный", style: TextStyle(color: Colors.white),)
                ),
                ElevatedButton(
                    onPressed:  () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinalWidget(name: widget.name, age: widget.age, group: widget.group, color: Colors.orange)));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                    child: Text("Оранжевый", style: TextStyle(color: Colors.white),)
                ),
                ElevatedButton(
                    onPressed:  () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinalWidget(name: widget.name, age: widget.age, group: widget.group, color: Colors.yellow)));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                    child: Text("Жёлтый", style: TextStyle(color: Colors.black),)
                ),
                ElevatedButton(
                    onPressed:  () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinalWidget(name: widget.name, age: widget.age, group: widget.group, color: Colors.green)));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text("Зелёный", style: TextStyle(color: Colors.white),)
                ),
                ElevatedButton(
                    onPressed:  () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinalWidget(name: widget.name, age: widget.age, group: widget.group, color: Colors.cyan)));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                    child: Text("Голубой", style: TextStyle(color: Colors.white),)
                ),
                ElevatedButton(
                    onPressed:  () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinalWidget(name: widget.name, age: widget.age, group: widget.group, color: Colors.blue)));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text("Синий", style: TextStyle(color: Colors.white),)
                ),
                ElevatedButton(
                    onPressed:  () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinalWidget(name: widget.name, age: widget.age, group: widget.group, color: Colors.purple)));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                    child: Text("Фиолетовый", style: TextStyle(color: Colors.white),)
                ),
              ],)
          ],
        ),
      ),
    );
  }
}