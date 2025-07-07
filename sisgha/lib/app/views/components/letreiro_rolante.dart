import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/cache/escolha_calendario.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/estilos.dart';

class LetreiroRolante extends StatefulWidget {
  const LetreiroRolante({super.key});

  @override
  State<LetreiroRolante> createState() => _LetreiroRolanteState();
}

class _LetreiroRolanteState extends State<LetreiroRolante> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: estiloBorda(
        cor: CoresClaras.verdecinzaBorda,
        radius: 15,
        grossuraBorda: 2,
      ),
      child: Center(
        child: Consumer<EscolhaCalendario>(
          builder:
              (BuildContext context, EscolhaCalendario value, Widget? child) =>
                  TextScroll(
            velocity: Velocity(pixelsPerSecond: Offset(10, 0)),
            'Técnico Integrado - Informática 2023 - 2023',
            style: estiloTexto(15,
                cor: CoresClaras.verdePrincipal, peso: FontWeight.bold),
            mode: TextScrollMode.bouncing,
          ),
        ),
      ),
    );
  }
}
