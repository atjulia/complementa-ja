import 'documento.dart';

class Usuario {
  final int id;
  final String nome;
  final String curso;
  final int horasNecessarias;
  final int horasConcluidas;
  final double progress;
  final int percent;
  final List<Documento> documentos;

  Usuario(
      {required this.id,
      required this.nome,
      required this.curso,
      required this.horasNecessarias,
      required this.horasConcluidas,
      required this.progress,
      required this.percent,
      required this.documentos});
}
