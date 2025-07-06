import 'package:flutter/material.dart';

class Eventos {
  final String titulo;
  final String inicio;
  final String termino;
  final String tempo;
  final String local;
  final Color cor;

  Eventos(
      {required this.titulo,
      required this.inicio,
      required this.termino,
      required this.tempo,
      required this.local,
      required this.cor});
}
