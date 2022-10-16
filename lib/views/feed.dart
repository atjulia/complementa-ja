import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

class Feed extends StatelessWidget {
  double progress = 0.7;
  int percent = 70;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: primaryColor,
        body: Column(
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(logo, width: 40),
                  Column(
                    children: [
                      Text('Olá Júlia Karolina', // colocar nome vindo do banco
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Engenharia de Software', // colocar curso vindo do banco
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
              const SizedBox(height: 44),
              Container(
                width: 370,
                height: 165,
                decoration: BoxDecoration(
                  color: const Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              children: [
                                Text('Horas Completas:',
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('x h de x h', // trocar para horas
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 120,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(10),
                                  child: CircularPercentIndicator(
                                    radius: 50.0,
                                    lineWidth: 4.0,
                                    percent: percent/100,
                                    center: Text(
                                      percent.toString() + "%", // progresso
                                      style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w600,
                                          color: primaryColor),
                                    ),
                                    backgroundColor: Color(0xffCCCCCC),
                                    circularStrokeCap: CircularStrokeCap.round,
                                    progressColor: primaryColor,
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 26),
              const Divider(
                indent: 130,
                endIndent: 130,
                color: Colors.white,
              ),
              const SizedBox(height: 32),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(15)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)))),
                child: Text(
                  "Enviar documentos para validação",
                  style: GoogleFonts.inter(
                    fontSize: 15.0,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              Row (
                children: [
                  const SizedBox(width: 64),
                  Align (
                    alignment: Alignment.topLeft,
                    child: Text('Últimos envios:',
                      textAlign: TextAlign.right,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                  )
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: 370,
                height: 256,
                decoration: BoxDecoration(
                  color: const Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(8),
                ),
              )
            ]
        ),
      ),
    );
  }
}