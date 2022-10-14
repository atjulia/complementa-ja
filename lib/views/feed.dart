import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff6B0D0F),
        body: Column(
            children: [
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(logo, width: 40),
                  Column(
                    children: [
                      Text('Olá Júlia Karolina',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Engenharia de Software',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SvgPicture.asset(notification, width: 32),
                ],
              ),
              SizedBox(height: 44),
              Container(
                width: 342,
                height: 165,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(height: 26),
              Divider(
                indent: 130,
                endIndent: 130,
                color: Colors.white,
              ),
              SizedBox(height: 32),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)))),
                child: Text(
                  "Enviar documentos para validação",
                  style: GoogleFonts.inter(
                    fontSize: 15.0,
                    color: Color(0xff6B0D0F),
                  ),
                ),
              ),
              SizedBox(height: 36),
              Text('Últimos envios:',
                textAlign: TextAlign.right,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Container(
                width: 342,
                height: 256,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              )
            ]
        ),
      ),
    );
  }
}