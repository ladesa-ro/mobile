import 'dart:ui';

import 'package:sisgha/app/views/professor/calendario/calendario.dart';

class Etapas {
  final int numero;
  final DateTime dataInicio;
  final DateTime dataTermino;
  final Color cor;

  Etapas({
    required this.numero,
    required this.dataInicio,
    required this.dataTermino,
    required this.cor,
  });

  factory Etapas.fromJson(Map<String, dynamic> json) {
    final inicio = DateTime.parse(json['dataInicio']);
    final fim = DateTime.parse(json['dataTermino']);

    return Etapas(
        numero: json['numero'],
        dataInicio: normalizarData(inicio),
        dataTermino: normalizarData(fim),
        cor: Color(int.parse(json['cor'].replaceFirst('#', '0xff'))));
  }
}
