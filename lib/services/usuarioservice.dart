import 'dart:convert';

import 'package:complementa_ja/model/usuario.dart';
import 'package:http/http.dart' as http;

import '../model/documento.dart';

class UsuarioService {
  Future<Usuario> getUsuarioInfo(int userId) async {
    Uri url = Uri.parse("https://complementa-ja.herokuapp.com/complementaja/usuario/" + userId.toString());
    http.Response response = await http.get(url);

    utf8.decode(response.bodyBytes);
    var data = response.body;
    int id = jsonDecode(data)['id'];
    String nome = jsonDecode(data)['nome'];
    String curso = jsonDecode(data)['curso']['nomeCurso'];
    int horasNecessarias = jsonDecode(data)['horasNecessarias'];
    int horasConcluidas = jsonDecode(data)['horasConcluidas'];
    double progress = horasConcluidas / horasNecessarias;
    int percent = (progress * 100).toInt();

    List<Documento> documentos = [];

    for (var item in jsonDecode(data)['documentos']) {
      String nomeDocumento = item['nomeDocumento'];
      String tipoDocumento = item['tipoDocumento'];
      bool? statusDocumentoAux = item['aceito'];
      String statusDocumento = '';

      if (statusDocumentoAux == null) {
        statusDocumento = "Pendente";
      } else if (statusDocumentoAux == true) {
        statusDocumento = "Aceito";
      } else {
        statusDocumento = "Rejeitado";
      }

      Documento documento = Documento(
          nomeDocumento: nomeDocumento,
          tipoDocumento: tipoDocumento,
          statusDocumento: statusDocumento);

      documentos.add(documento);
    }

    return Usuario(
        id: id.toInt(),
        nome: nome,
        curso: curso,
        horasNecessarias: horasNecessarias,
        horasConcluidas: horasConcluidas,
        progress: progress,
        percent: percent,
        documentos: documentos);
  }
}
