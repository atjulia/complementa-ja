import 'dart:io';
import 'dart:math';

import 'package:complementa_ja/constants.dart';
import 'package:complementa_ja/services/formularioservice.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  State<Formulario> createState() => _FormularioState();
}

late List<String> listValue = [
  "Certificado de curso",
  "Certificado de participação em palestra",
  "Certificado de participação em projeto social",
  "Outros"
];

class _FormularioState extends State<Formulario> {
  late String tipoDocumento = listValue.first;
  late int fileLength = 0;

  late FormData form = new FormData();
  FormularioService formularioService = FormularioService();

  late TextEditingController controllerNomeDocumento =
      new TextEditingController();
  late TextEditingController controllerEmissao = new TextEditingController();
  late TextEditingController controllerInstituicaoEmissora =
      new TextEditingController();
  late TextEditingController controllerHorasValidas =
      new TextEditingController();
  late TextEditingController controllerAnxDocumento =
      new TextEditingController();

  void setFormData() async {
    form.nomeDocumento = controllerNomeDocumento.text;
    if (controllerHorasValidas.text != "") {
      form.horasValidas = int.parse(controllerHorasValidas.text);
    }
    form.dataEmissao = controllerEmissao.text;
    form.instituicaoEmissora = controllerInstituicaoEmissora.text;
  }

  void doSubmit() async {
    setFormData();

    if (form.arquivo == null ||
        form.arquivo == File('') ||
        form.nomeDocumento == "" ||
        form.nomeDocumento == null ||
        form.horasValidas == "" ||
        form.horasValidas == null ||
        form.dataEmissao == "" ||
        form.dataEmissao == null ||
        form.dataEmissao.length < 10 ||
        form.instituicaoEmissora == "" ||
        form.instituicaoEmissora == null) {
      _validationDialog(context);
    } else {
      var res = await formularioService.sendForm(
          form.arquivo.lengthSync(),
          form.arquivo,
          form.nomeDocumento,
          tipoDocumento,
          form.horasValidas,
          form.dataEmissao,
          form.instituicaoEmissora);
      if (res) {
        _successDialog(context);
      } else {
        _erroDialog(context);
      }
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24, top: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tipo de documento'),
                    DropdownButton<String>(
                      isExpanded: true,
                      value: tipoDocumento,
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: primaryColor,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          tipoDocumento = value!;
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [DateTextFormatter()],
                      onChanged: (String value) {},
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
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
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
                        if (result != null) {
                          File fileMobile = File(result.files.single.path!);
                          form.arquivo = fileMobile;
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 24.0, right: 24, top: 32, bottom: 15),
                child: OutlinedButton(
                  onPressed: () {
                    doSubmit();
                  },
                  style: OutlinedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),
                      side: const BorderSide(width: 0.5, color: primaryColor),
                      padding: (const EdgeInsets.all(0)),
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
        ));
  }
}

class FormData {
  late File arquivo = File('');
  late String nomeDocumento = '';
  late int horasValidas = 0;
  late String dataEmissao = '';
  late String instituicaoEmissora = '';
}

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '/');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 3) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

Future<void> _successDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Sucesso'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Arquivo enviado com sucesso!'),
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
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Erro'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(
                  'Ocorreu um erro ao enviar o documento, verifique os campos e tente novamente'),
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

Future<void> _validationDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Atenção'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(
                  'Preencha todos os campos corretamente para enviar o documento'),
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