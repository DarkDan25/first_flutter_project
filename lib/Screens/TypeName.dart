import 'package:flutter/material.dart';
import 'package:first_flutter_project/Screens/TypeAge.dart';

class TypeName extends StatefulWidget{
  const TypeName({super.key});

  @override
  State<TypeName> createState() => _TypeNameState();
}

class _TypeNameState extends State<TypeName>{
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("1. Введи ФИО"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Введи имя"),
            TextField(controller: myController),
            Text("Введи Фамилию"),
            TextField(controller: myController2),
            Text("Введи Отчество"),
            TextField(controller: myController3),
            ElevatedButton(
                onPressed:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TypeAge(name: "${myController2.text} ${myController.text} ${myController3.text}",)));
                },
                child: Text("Далее"))
          ],
        ),
      ),
    );
  }
}