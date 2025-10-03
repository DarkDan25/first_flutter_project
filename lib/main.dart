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
      title: 'Flutter Demo',
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
        title: Text(widget.title),
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
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Введи имя"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Введи имя"),
            TextField(controller: myController),
            ElevatedButton(
                onPressed:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TypeAge(name: myController.text,)));
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
        title: Text(widget.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Введи возраст"),
            TextField(controller: myController),
            ElevatedButton(
                onPressed:  () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TypeAge(name: myController.text,)));
                },
                child: Text("Далее"))
          ],
        ),
      ),
    );
  }
}