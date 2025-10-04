import 'package:flutter/material.dart';
import 'package:first_flutter_project/Screens/ChooseColor.dart';

class TypeGroup extends StatefulWidget{
  final String name;
  final String age;

  const TypeGroup({super.key, required this.name, required this.age});

  @override
  State<TypeGroup> createState() => _TypeGroupState();
}

class _TypeGroupState extends State<TypeGroup>{
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("3. ${widget.age}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Введи группу"),
            TextField(controller: myController),
            ElevatedButton(
                onPressed:  () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseColor(
                      name: widget.name,
                      age: widget.age,
                      group: myController.text )));
                },
                child: Text("Далее"))
          ],
        ),
      ),
    );
  }
}
