import 'package:flutter/material.dart';
import '/views/login.dart';
import '/views/feed.dart';

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
        home: Feed(),
      ),
    );
  }
}
