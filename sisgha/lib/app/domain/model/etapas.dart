import 'dart:ui';

class Etapas {
  final int numero;
  final DateTime dataInicio;
  final DateTime dataTermino;
  final Color cor;

  Etapas(
      {required this.numero,
      required this.dataInicio,
      required this.dataTermino,
      required this.cor});

  factory Etapas.fromJson(Map<String, dynamic> json) {
    return Etapas(
        numero: json['numero'],
        dataInicio: DateTime.parse(json['dataInicio']),
        dataTermino: DateTime.parse(json['dataTermino']),
        cor: Color(int.parse(json['cor'].replaceFirst('#', '0xff'))));
  }
}
