import 'package:complementa_ja/services/loginservice.dart';
import 'package:complementa_ja/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'feed.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  String password = '';

  final prefs = SharedPreferences.getInstance();
  bool isPasswordVisible = true;

  void doLogin() async {
    var res = await LoginService().validaLogin(emailController.text, password);
    final prefs = await SharedPreferences.getInstance();
    if (res) {
      loginService.getUsuario(emailController.text, password).then((Usuario u) {
        prefs.clear();
        prefs.setInt('id', u.id);
        pushToFeed(u);
      });
    } else {
      _errorDialog();
    }
  }

  Future<void> _errorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Não foi possível realizar seu login.'),
                Text('E-mail ou senha inválidos.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void pushToFeed(Usuario u) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Feed(usuario: u);
    }));
  }

  LoginService loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: const Color(0xff6B0D0F),
            body: SingleChildScrollView(
                child: SafeArea(
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 15),
                              SvgPicture.asset(logo, fit: BoxFit.scaleDown),
                              SizedBox(height: 50),
                              Text(
                                'Complementa Já',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
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
                                // JOGAR ISSO PRA DENTRO DA FUNÇÃO DE LOGIN -- REDIRECIONA ROTA
                                onPressed: () => {doLogin()},
                                // fazer validação conforme o usuário
                                child: Text('Entrar',
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              SizedBox(height: 36),
                            ]))))));
  }

  Widget insertUser() => TextField(
        controller: emailController,
        style: TextStyle(),
        decoration: InputDecoration(
            hintText: 'Login',
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
        style: TextStyle(),
        decoration: InputDecoration(
            hintText: 'Senha',
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
