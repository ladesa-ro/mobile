// =-------------------------------------------------------------
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../core/utils/dias.dart';
import '../core/utils/estilos.dart';
import '../core/utils/padroes.dart';
import '../viewmodels/escolha_horarios_alunos.dart';

class InfoAlternada extends StatefulWidget {
  final EscolhaHorariosAlunos? provInfo;
  const InfoAlternada({super.key, this.provInfo});

  @override
  State<InfoAlternada> createState() => _InfoAlternadaState();
}

class _InfoAlternadaState extends State<InfoAlternada> {
  bool mostrarTurma = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // alterna a cada 3 segundos
    _timer = Timer.periodic(const Duration(seconds: 8), (_) {
      setState(() {
        mostrarTurma = !mostrarTurma;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provInfo = widget.provInfo;

    // decide o que mostrar
    final String textoBase = mostrarTurma && provInfo?.turmaSelecionada != null
        ? provInfo!.turmaSelecionada!
        : DatasFormatadas.diaAtual;

    final textoSeparado = Padroes.separarTexto(textoBase);
    dynamic mostrar = textoSeparado.isEmpty ? textoBase : textoSeparado;
    final tema = Theme.of(context).colorScheme;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, anim) => FadeTransition(
        opacity: anim,
        child: child,
      ),
      child: SizedBox(
        key: ValueKey(textoBase), // necessário pro AnimatedSwitcher
        child: textoSeparado.isEmpty
            ? Text(
                textoBase,
                style: estiloTexto(26,
                    cor: tema.inversePrimary, peso: FontWeight.bold),
                maxLines: 2,
              )
            : Column(
                children: [
                  Text(mostrar[0],
                      style: estiloTexto(17,
                          cor: tema.inversePrimary, peso: FontWeight.bold)),
                  Text(mostrar[1],
                      style: estiloTexto(17,
                          cor: tema.inversePrimary, peso: FontWeight.bold)),
                ],
              ),
      ),
    );
  }
}

// =-------------------------------------------------
class TituloAlternado extends StatefulWidget {
  final EscolhaHorariosAlunos? provInfo;
  final bool existeSelecionado;
  const TituloAlternado({
    super.key,
    required this.provInfo,
    required this.existeSelecionado,
  });

  @override
  State<TituloAlternado> createState() => _TituloAlternadoState();
}

class _TituloAlternadoState extends State<TituloAlternado> {
  bool mostrarDia = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 8), (_) {
      setState(() => mostrarDia = !mostrarDia);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provInfo = widget.provInfo;
    final existeSelecionado = widget.existeSelecionado;

    final texto = existeSelecionado
        ? (mostrarDia
            ? DatasFormatadas.diaExtenso
            : '${provInfo!.nomeFormacaoSelecionada} - ${DatasFormatadas.anoAtual}')
        : DatasFormatadas.diaExtenso;

    final tema = Theme.of(context).colorScheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, anim) =>
          FadeTransition(opacity: anim, child: child),
      child: SizedBox(
        key: ValueKey(texto),
        width: existeSelecionado ? 45.w : null,
        child: Text(
          Padroes.primeiraLetraMaiuscula(texto),
          style:
              estiloTexto(15, cor: tema.inversePrimary, peso: FontWeight.bold),
          maxLines: 2,
        ),
      ),
    );
  }
}

//=-----------------------------------------------------------------------------------
class SubtituloAlternado extends StatefulWidget {
  const SubtituloAlternado({super.key, required this.existeSelecionado});
  final bool existeSelecionado;

  @override
  State<SubtituloAlternado> createState() => _SubtituloAlternadoState();
}

class _SubtituloAlternadoState extends State<SubtituloAlternado> {
  bool mostrarSemana = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 8), (_) {
      setState(() => mostrarSemana = !mostrarSemana);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String mes = DatasFormatadas.mesAtual;
    final String primDia = DatasFormatadas.obterPrimeiroDiaSemana();
    final String ultDia = DatasFormatadas.obterUltimoDiaSemana();

    final texto = widget.existeSelecionado
        ? (mostrarSemana
            ? '${Padroes.primeiraLetraMaiuscula(mes)} - Dia $primDia a $ultDia'
            : null)
        : '${Padroes.primeiraLetraMaiuscula(mes)} - Dia $primDia a $ultDia';

    final tema = Theme.of(context).colorScheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, anim) =>
          FadeTransition(opacity: anim, child: child),
      child: texto == null
          ? null
          : Text(
              texto,
              key: ValueKey(texto),
              style: estiloTexto(15,
                  cor: tema.inversePrimary, peso: FontWeight.bold),
            ),
    );
  }
}
