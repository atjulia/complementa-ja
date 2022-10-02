import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'variables.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Container(
              color: Color(0xff6B0D0F),
              child: Align(
                alignment:  Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.only(top: 75),
                  child: SvgPicture.asset(logo),
                ),
              )
            ),
          )
      );
  }
}
