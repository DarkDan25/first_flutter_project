import 'package:first_flutter_project/app_router.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_project/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Запись к врачу',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false
      );
  }
}