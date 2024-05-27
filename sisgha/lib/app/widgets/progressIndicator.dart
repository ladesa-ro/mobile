import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Progressindicator extends StatefulWidget {
  final double tamanho;

  const Progressindicator({Key? key, required this.tamanho}) : super(key: key);

  @override
  State<Progressindicator> createState() => _ProgressindicatorState();
}

class _ProgressindicatorState extends State<Progressindicator> {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset('img/teste.json', width: widget.tamanho);
  }
}
