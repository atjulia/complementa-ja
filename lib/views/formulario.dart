import 'package:complementa_ja/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Formulario extends StatefulWidget {
  const Formulario({Key? key}) : super(key: key);

  @override
  State<Formulario> createState() => _FormularioState();
}

late List<String> listValue = ["Selecione", "PDF", "Documento"];

class _FormularioState extends State<Formulario> {
  late String initalValue = listValue.first;

  late Solicitacao model = new Solicitacao();
  late TextEditingController controllerNome = new TextEditingController();
  late TextEditingController controllerConclusao = new TextEditingController();
  late TextEditingController controllerInstituicao = new TextEditingController();
  late TextEditingController controllerAnxDocumento = new TextEditingController();

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
                      model.documento = value;
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
                  controller: controllerNome,
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
                Text('Data de Conclusão'),
                TextFormField(
                  controller: controllerConclusao,
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
                  controller: controllerInstituicao,
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
                Text('Anexar documento'),
                TextFormField(
                  controller: controllerAnxDocumento,
                  cursorColor: primaryColor,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24, top: 32),
            child: OutlinedButton(
              onPressed: () {
                model.nome = controllerNome.text;
                model.conclusao = controllerConclusao.text;
                model.instituicao = controllerInstituicao.text;
                model.anxDocumento = controllerAnxDocumento.text;// se faz normalmente pra texto

                //debugPrint(model.documento);
                debugPrint(model.nome);
                debugPrint(model.conclusao);
                debugPrint(model.instituicao);
                debugPrint(model.anxDocumento);


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

class Solicitacao {
  late String documento;
  late String nome;
  late String conclusao;
  late String instituicao;
  late String anxDocumento;
}