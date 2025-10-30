import 'package:flutter/material.dart';

class MostrarNoCalendario {
  final String id;
  final String titulo;
  final String? tempo;
  final String dataInicio;
  final String? dataTermino;
  final Color cor;

  MostrarNoCalendario({
    this.tempo,
    this.dataTermino,
    required this.id,
    required this.titulo,
    required this.dataInicio,
    required this.cor,
  });
}
