import 'package:complementa_ja/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../constants.dart';
import '../model/documento.dart';
import '../services/usuarioservice.dart';
import 'formulario.dart';

class Feed extends StatefulWidget {
  final Usuario usuario;

  const Feed({required this.usuario, Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late int id;
  late double progress;
  late int percent;
  late int horas;
  late int horasNecessarias;
  late String nome;
  late String curso;
  late List<Documento> documentos;

  void setUserData(Usuario u) async {
    id = u.id;
    progress = u.progress;
    percent = u.percent;
    horas = u.horasConcluidas;
    nome = u.nome.split(' ')[0];
    curso = u.curso;
    horasNecessarias = u.horasNecessarias;
    documentos = u.documentos;
  }

  void atualizar() {
    UsuarioService uService = UsuarioService();
    uService.getUsuarioInfo(id).then((value) {
      setState(() {
        setUserData(value);
      });
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setUserData(widget.usuario);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        endDrawer: Formulario(),
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(logo, width: 40),
                Column(
                  children: [
                    Text(
                      'Olá $nome',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 25,
                        color: primaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      curso,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.refresh,
                      color: primaryTextColor, size: 35),
                  onPressed: () {
                    atualizar();
                  },
                  //child: SvgPicture.asset(refresh, width: 32),
                )
              ],
            ),
            const SizedBox(height: 44),
            Container(
              width: 370,
              height: 165,
              decoration: BoxDecoration(
                color: primaryTextColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              Text(
                                'Horas Completas',
                                textAlign: TextAlign.right,
                                style: GoogleFonts.inter(
                                  fontSize: 17,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '$horas h de $horasNecessarias h',
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  percent: percent / 100,
                                  center: Text(
                                    percent.toString() + "%",
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w600,
                                        color: primaryColor),
                                  ),
                                  backgroundColor: Color(0xffCCCCCC),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: primaryColor,
                                )),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: OutlinedButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                style: OutlinedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                    side: const BorderSide(width: 0.5, color: Colors.white),
                    padding: (const EdgeInsets.all(15)),
                    shape: (RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Enviar documentos",
                      style: GoogleFonts.inter(
                        fontSize: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Documentos enviados',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: primaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: 370,
              height: 280,
              decoration: BoxDecoration(
                color: primaryTextColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: documentos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${documentos[index].nomeDocumento} - ${documentos[index].statusDocumento}',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      documentos[index].tipoDocumento,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}
