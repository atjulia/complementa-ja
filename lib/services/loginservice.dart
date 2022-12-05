import 'package:complementa_ja/services/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {

  Future validaLogin(String email, String senha) async {
    Uri url = Uri.parse("http://localhost:8080/complementaja/usuario/login");
    Map<String, String> body = {
      'email': email,
      'senha': senha
    };
    final headers = {'Content-Type': 'application/json'};

    http.Response response = await http.post(
      url,
      body: jsonEncode(body),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
     print("Login ou senha inválidos ou usuário não encontrado");
     return false;
    }
  }

  Future<Usuario> getUsuario(String email, String senha) async {
    Uri url = Uri.parse("http://localhost:8080/complementaja/usuario/login");
    Map<String, String> body = {
      'email': email,
      'senha': senha
    };
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
      percent: percent
    );

  }

}
