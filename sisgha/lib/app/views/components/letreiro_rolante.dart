import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/estilos.dart';

class LetreiroRolante extends StatefulWidget {
  const LetreiroRolante({super.key});

  @override
  State<LetreiroRolante> createState() => _LetreiroRolanteState();
}

class _LetreiroRolanteState extends State<LetreiroRolante> {
  final ScrollController _controller = ScrollController();
  bool _direcao = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _iniciarAnimacao());
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
      _direcao = !_direcao;
      Future.delayed(const Duration(milliseconds: 1500), _iniciarAnimacao);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: estiloBorda(
          cor: CoresClaras.verdecinzaBorda,
          radius: 15,
          grossuraBorda: 2,
        ),
        child: ListView(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          children: [
            Center(
              child: Text(
                'Técnico Integrado - Informática 2023 - 2023',
                style: estiloTexto(
                  17,
                  cor: CoresClaras.verdePrincipalTexto,
                  peso: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
