import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Practice 3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("${widget.title} Практика 3"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Перейди на другой экран"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TypeName()));
                },
                child: Text("Далее"))
          ],
        ),
      ),
    );
  }
}

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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TypeColor(
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

class TypeColor extends StatefulWidget{
  final String name;
  final String age;
  final String group;

  const TypeColor({super.key, required this.name, required this.age, required this.group});

  @override
  State<TypeColor> createState() => _TypeColorState();
}

class _TypeColorState extends State<TypeColor>{
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