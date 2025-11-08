import 'package:flutter/material.dart';

class MostrarNoCalendario {
  final String id;
  final String titulo;
  final DateTime dataReal; // <-- add
  final String dataInicio;
  final String dataTermino;
  final Color cor;
  final String tempo;

  MostrarNoCalendario({
    required this.id,
    required this.titulo,
    required this.dataReal,
    required this.dataInicio,
    required this.dataTermino,
    required this.cor,
    required this.tempo,
  });
}
