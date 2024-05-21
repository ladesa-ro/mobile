import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Progressindicator extends StatefulWidget {
  const Progressindicator({super.key});

  @override
  State<Progressindicator> createState() => _ProgressindicatorState();
}

class _ProgressindicatorState extends State<Progressindicator> {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/img/relogio.json');
  }
}
