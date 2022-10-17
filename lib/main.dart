import 'package:flutter/material.dart';

import 'routes.dart' as route;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialApp(
        title: 'Complementa Já',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        primarySwatch: Colors.blue
        ),
          onGenerateRoute: route.controller,
          initialRoute: route.loginPage,
      ),
    );
  }
}
