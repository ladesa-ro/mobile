import 'package:flutter/material.dart';

class MostrarNoCalendario {
  final String titulo;
  final String? tempo;
  final String? local;
  final String dataInicio;
  final String? dataTermino;
  final Color cor;

  MostrarNoCalendario({
    this.tempo,
    this.local,
    this.dataTermino,
    required this.titulo,
    required this.dataInicio,
    required this.cor,
  });
}
