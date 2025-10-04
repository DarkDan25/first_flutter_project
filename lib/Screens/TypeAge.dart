import 'package:flutter/material.dart';
import 'package:first_flutter_project/Screens/TypeGroup.dart';

class TypeAge extends StatefulWidget{
  final String name;

  const TypeAge({super.key, required this.name});

  @override
  State<TypeAge> createState() => _TypeAgeState();
}

class _TypeAgeState extends State<TypeAge>{
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("2. ${widget.name}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Введи возраст"),
            TextField(controller: myController),
            ElevatedButton(
                onPressed:  () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TypeGroup(age: myController.text,name: widget.name)));
                },
                child: Text("Далее"))
          ],
        ),
      ),
    );
  }
}
