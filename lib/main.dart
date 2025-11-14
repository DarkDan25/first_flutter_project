import 'package:first_flutter_project/app_router.dart';
import 'package:first_flutter_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_project/app_state.dart';
import 'package:first_flutter_project/locator.dart';

void main() {
  setupLocator()
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
        child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Запись к врачу',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false
      )
    );
  }
}