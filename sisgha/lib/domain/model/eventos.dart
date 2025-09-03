import 'package:flutter/material.dart';
import 'package:sisgha/views/professor/calendario/calendario.dart';

class Eventos {
  final String nome;
  final String rrule;
  final Color cor;
  final DateTime dataInicio;
  final DateTime dataTermino;

  Eventos({
    required this.nome,
    required this.rrule,
    required this.cor,
    required this.dataInicio,
    required this.dataTermino,
  });

  factory Eventos.fromJson(Map<String, dynamic> json) {
    final inicio = DateTime.parse(json['data_inicio']);
    final fim = DateTime.parse(json['data_fim']);
    return Eventos(
      nome: json['nome'],
      rrule: json['rrule'],
      cor: Color(int.parse(json['cor'].replaceFirst('#', '0xff'))),
      dataInicio: normalizarData(inicio),
      dataTermino: normalizarData(fim),
    );
  }
}
