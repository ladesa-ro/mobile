import 'package:flutter/material.dart';

class Eventos {
  final String nome;
  final String rrule;
  final Color cor;

  Eventos({required this.nome, required this.rrule, required this.cor});

  factory Eventos.fromJson(Map<String, dynamic> json) {
    return Eventos(
      nome: json['nome'],
      rrule: json['rrule'],
      cor: Color(int.parse(json['cor'].replaceFirst('#', '0xff'))),
    );
  }
}
