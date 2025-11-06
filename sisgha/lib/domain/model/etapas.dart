import 'dart:ui';

import 'package:sisgha/core/utils/padroes.dart';
import 'package:sisgha/views/professor/calendario/calendario.dart';

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
      cor: Color(Padroes.verificarCorExistente(json['cor'])),
    );
  }
}
