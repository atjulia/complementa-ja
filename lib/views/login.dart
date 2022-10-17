import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

import '../routes.dart' as route;

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  bool isPasswordVisible = true;
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: const Color(0xff6B0D0F),
            body: SafeArea(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            logo,
                            fit: BoxFit.scaleDown
                          ),
                          SizedBox(height: 64),
                          Text(
                            'Complementa Já',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: 250,
                            child: Text(
                              'O seu portal de validação de horas complementares',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            padding: EdgeInsets.all(30),
                            child: Column(
                              children: [
                                insertUser(), //emailController.text
                                SizedBox(height: 12),
                                insertPassoword(), //password
                              ],
                            ),
                          ),
                          SizedBox(height: 35),
                          const Divider(
                            indent: 130,
                            endIndent: 130,
                            color: primaryTextColor,
                          ),
                          SizedBox(height: 35),
                          MaterialButton(
                            minWidth: 342.0,
                            height: 48,
                            color: buttonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            onPressed: () => Navigator.pushNamed(
                                context,
                                route
                                    .feedPage), // fazer validação conforme o usuário
                            child: Text('Entrar',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          SizedBox(height: 48),
                        ])))));
  }

  Widget insertUser() => TextField(
        controller: emailController,
        style: TextStyle(color: primaryTextColor),
        decoration: InputDecoration(
            labelText: 'Login',
            prefixIcon: Icon(FontAwesomeIcons.userCircle),
            filled: true,
            fillColor: primaryTextColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: secondaryColor, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: secondaryColor, width: 2))),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      );

  Widget insertPassoword() => TextField(
        onChanged: (value) => setState(() => this.password = value),
        onSubmitted: (value) => setState(() => this.password = value),
        style: TextStyle(color: primaryTextColor),
        decoration: InputDecoration(
            labelText: 'Senha',
            prefixIcon: Icon(FontAwesomeIcons.lock),
            suffixIcon: IconButton(
              icon: isPasswordVisible
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onPressed: () =>
                  setState(() => isPasswordVisible = !isPasswordVisible),
            ),
            filled: true,
            fillColor: primaryTextColor,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: secondaryColor, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: secondaryColor, width: 2))),
        obscureText: isPasswordVisible,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      );
}
