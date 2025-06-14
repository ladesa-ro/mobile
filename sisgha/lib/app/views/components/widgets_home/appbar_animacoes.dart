import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/utils/dias.dart';

class AppBarAnimacoes {
  final TickerProvider vsync;
  final String diaHoje;
  final String mes;
  final bool animacaoAtiva;
  final VoidCallback onUpdate;

  late AnimationController controllerTextoPrincipal;
  late Animation<Offset> slideTextoPrincipal;
  late Animation<double> fadeTextoPrincipal;
  String textoPrincipal = '';

  late AnimationController controllerSubTexto;
  late Animation<Offset> slideSubTexto;
  late Animation<double> fadeSubTexto;
  String linha1 = '';
  String linha2 = '';

  bool mostrarTurma = false;
  Timer? _timer;

  AppBarAnimacoes({
    required this.vsync,
    required this.diaHoje,
    required this.mes,
    required this.animacaoAtiva,
    required this.onUpdate,
  }) {
    textoPrincipal = DatasFormatadas.diaAtual;
    linha1 = diaHoje;
    linha2 = mes;

    controllerTextoPrincipal = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    );

    slideTextoPrincipal = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: controllerTextoPrincipal,
      curve: Curves.easeInOut,
    ));

    fadeTextoPrincipal = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: controllerTextoPrincipal,
      curve: Curves.easeInOut,
    ));

    controllerSubTexto = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    );

    slideSubTexto = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
      parent: controllerSubTexto,
      curve: Curves.easeInOut,
    ));

    fadeSubTexto = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: controllerSubTexto,
      curve: Curves.easeInOut,
    ));

    if (animacaoAtiva) {
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        _trocarTextos();
      });
    }
  }

  Future<void> _trocarTextos() async {
    if (!animacaoAtiva) return;

    await Future.wait([
      controllerTextoPrincipal.forward(),
      controllerSubTexto.forward(),
    ]);

    mostrarTurma = !mostrarTurma;
    textoPrincipal = mostrarTurma ? '1°A' : DatasFormatadas.diaAtual;
    linha1 = mostrarTurma ? 'Técnico' : diaHoje;
    linha2 = mostrarTurma ? 'Informática 2023' : mes;

    onUpdate();

    controllerTextoPrincipal.reset();
    controllerSubTexto.reset();

    await Future.delayed(const Duration(milliseconds: 50));

    await Future.wait([
      controllerTextoPrincipal.reverse(),
      controllerSubTexto.reverse(),
    ]);
  }

  void dispose() {
    _timer?.cancel();
    controllerTextoPrincipal.dispose();
    controllerSubTexto.dispose();
  }
}
