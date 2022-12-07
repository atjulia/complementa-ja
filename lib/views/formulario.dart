import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:complementa_ja/constants.dart';
import 'package:complementa_ja/services/formularioservice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  State<Formulario> createState() => _FormularioState();
}

late List<String> listValue = ["Certificado de curso", "Certificado de participação em palestra", "Certificado de participação em projeto social", "Outros"];

class _FormularioState extends State<Formulario> {
  late String initalValue = listValue.first;

  late FormData form = new FormData();
  FormularioService formularioService = FormularioService();

  late TextEditingController controllerNomeDocumento = new TextEditingController();
  late TextEditingController controllerEmissao = new TextEditingController();
  late TextEditingController controllerInstituicaoEmissora = new TextEditingController();
  late TextEditingController controllerHorasValidas = new TextEditingController();
  late TextEditingController controllerAnxDocumento = new TextEditingController();

  void doSubmit() async {
    var res = await formularioService.sendForm(form.arquivo, form.nomeDocumento, form.tipoDocumento, form.horasValidas, form.dataEmissao, form.instituicaoEmissora);
    if (res) {
      _successDialog(context);
    } else {
      _erroDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Envio de Documento'),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tipo de documento'),
                DropdownButton<String>(
                  isExpanded: true,
                  value: initalValue,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: primaryColor,
                  ),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      initalValue = value!;
                      form.tipoDocumento = value;
                    });
                  },
                  items: listValue.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nome'),
                TextFormField(
                  controller: controllerNomeDocumento,
                  cursorColor: primaryColor,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Data de emissão/conclusão'),
                TextFormField(
                  controller: controllerEmissao,
                  cursorColor: primaryColor,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Horas válidas'),
                TextFormField(
                  controller: controllerHorasValidas,
                  cursorColor: primaryColor,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Organizado por qual instituição?'),
                TextFormField(
                  controller: controllerInstituicaoEmissora,
                  cursorColor: primaryColor,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                    color: buttonColor,
                  child: Text('Anexar documentos',
                      style: TextStyle(
                        color: secondaryColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      )),
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                    },
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24, top: 32),
            child: OutlinedButton(
              onPressed: () {
                doSubmit();
              },
              style: OutlinedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                  side: const BorderSide(width: 0.5, color: primaryColor),
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
                      color: primaryColor,
                    ),
                  ),
                  Text(
                    "Enviar solicitação",
                    style: GoogleFonts.inter(
                      fontSize: 15.0,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormData {
  late File arquivo;
  late String nomeDocumento;
  late String tipoDocumento;
  late int horasValidas;
  late String dataEmissao;
  late String instituicaoEmissora;

}

Future<void> _successDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Erro'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Erro ao enviar arquivo!'),
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

Future<void> _erroDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sucesso'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Seus documentos foram enviados para análise'),
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