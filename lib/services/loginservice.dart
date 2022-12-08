import 'dart:convert';

import 'package:complementa_ja/model/usuario.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future validaLogin(String email, String senha) async {
    Uri url = Uri.parse(
        "https://complementa-ja.herokuapp.com/complementaja/usuario/login");
    Map<String, String> body = {'email': email, 'senha': senha};
    final headers = {'Content-Type': 'application/json'};

    http.Response response = await http.post(
      url,
      body: jsonEncode(body),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Usuario> getUsuario(String email, String senha) async {
    Uri url = Uri.parse(
        "https://complementa-ja.herokuapp.com/complementaja/usuario/login");
    Map<String, String> body = {'email': email, 'senha': senha};
    final headers = {'Content-Type': 'application/json;charset=utf-8'};

    http.Response response = await http.post(
      url,
      body: jsonEncode(body),
      headers: headers,
    );

    utf8.decode(response.bodyBytes);
    var data = response.body;
    int id = jsonDecode(data)['id'];
    String nome = jsonDecode(data)['nome'];
    String curso = jsonDecode(data)['curso']['nomeCurso'];
    int horasNecessarias = jsonDecode(data)['horasNecessarias'];
    int horasConcluidas = jsonDecode(data)['horasConcluidas'];
    double progress = horasConcluidas / horasNecessarias;
    int percent = (progress * 100).toInt();

    return Usuario(
        id: id.toInt(),
        nome: nome,
        curso: curso,
        horasNecessarias: horasNecessarias,
        horasConcluidas: horasConcluidas,
        progress: progress,
        percent: percent);
  }
}
