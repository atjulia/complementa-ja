import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FormularioService {
  Future sendForm(
      int fileLength,
      File arquivo,
      String nomeDocumento,
      String tipoDocumento,
      int horasValidas,
      String dataEmissao,
      String instituicaoEmissora) async {
    final prefs = await SharedPreferences.getInstance();
    final int? id = prefs.getInt('id');

    var codTipoDocumento = 0;
    switch (tipoDocumento) {
      case "Certificado de curso":
        codTipoDocumento = 1;
        break;

      case "Certificado de participação em palestra":
        codTipoDocumento = 2;
        break;

      case "Certificado de participação em projeto social":
        codTipoDocumento = 3;
        break;

      case "Outros":
        codTipoDocumento = 4;
        break;
    }

    var stream =
        new http.ByteStream(DelegatingStream.typed(arquivo.openRead()));
    var length = fileLength;
    var uri = Uri.parse(
        "https://complementa-ja.herokuapp.com/complementaja/documento/enviar");
    var request = new http.MultipartRequest("POST", uri);

    request.fields["usuarioId"] = id.toString();
    var multipartFile = new http.MultipartFile('arquivo', stream, length,
        filename: 'arquivo.pdf');
    request.files.add(multipartFile);
    request.fields["nomeDocumento"] = nomeDocumento;
    request.fields["codTipoDocumento"] = codTipoDocumento.toString();
    request.fields["horasValidas"] = horasValidas.toString();
    request.fields["dataEmissao"] = dataEmissao;
    request.fields["instituicaoEmissora"] = instituicaoEmissora;

    var res = null;

    await request.send().then((response) async {
      if (response.statusCode == 200) {
        res = true;
      } else {
        res = false;
      }
    });

    return res;
  }
}
