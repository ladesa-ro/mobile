import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/estilos.dart';

class LetreiroRolante extends StatefulWidget {
  const LetreiroRolante({super.key});

  @override
  State<LetreiroRolante> createState() => _LetreiroRolanteState();
}

class _LetreiroRolanteState extends State<LetreiroRolante> {
  late final ScrollController _controller;
  bool _direcao = true;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _iniciarAnimacao();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _iniciarAnimacao() {
    if (!_controller.hasClients) return;

    final destino = _direcao
        ? _controller.position.maxScrollExtent
        : _controller.position.minScrollExtent;

    _controller
        .animateTo(
      destino,
      duration: const Duration(seconds: 10),
      curve: Curves.easeInOut,
    )
        .then((_) {
      _direcao ? _direcao = false : _direcao = true;
      Future.delayed(const Duration(milliseconds: 1500), _iniciarAnimacao);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => IgnorePointer(
        child: Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: estiloBorda(
              cor: ColorApp.VerdeCinzaBorda, radius: 15, grossuraBorda: 2),
          child: ListView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Técnico Integrado - Informática 2023 - 2023',
                  style: estiloTexto(15,
                      cor: ColorApp.VerdePrincipalTexto, peso: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
