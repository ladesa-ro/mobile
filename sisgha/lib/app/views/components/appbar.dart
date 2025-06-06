import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/utils/icones.dart';
import '../../core/utils/dias.dart';
import '../../core/utils/estilos.dart';
import '../../core/utils/padroes.dart';
import '../../providers/tema.dart';
import 'dialogo_troca_de_tema.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final String mes;
  final String diaHoje;
  final bool icones;

  const CustomAppBar({
    super.key,
    required this.height,
    required this.mes,
    required this.diaHoje,
    required this.icones,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool mostrarTurma = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {
          mostrarTurma = !mostrarTurma;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<TemasProvider>(context);
    return AppBar(
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      actions: [Container()],
      title: Padding(
        padding: Padroes.margem(),
        child: Row(
          children: [
            if (widget.icones)
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/acessoAluno',
                    (route) => false,
                  );
                },
                icon: Iconify(
                  Icones.setaVoltarDireita,
                  size: 40,
                  color: temaProvider.corDosIcones(),
                ),
              ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, animation) {
                final inAnimation = Tween<Offset>(
                  begin: const Offset(0, 1), // entra de baixo
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ));

                final outAnimation = Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(0, -1), // sai pra cima
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ));

                return SlideTransition(
                  position: child.key == ValueKey(mostrarTurma)
                      ? inAnimation
                      : outAnimation,
                  child: child,
                );
              },
              child: Text(
                mostrarTurma ? '1°A' : DatasFormatadas.diaAtual,
                key: ValueKey(mostrarTurma),
                style: estiloTexto(30, peso: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, animation) {
                final inAnimation = Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ));

                final outAnimation = Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(0, -1),
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ));

                return SlideTransition(
                  position: child.key == ValueKey(mostrarTurma)
                      ? inAnimation
                      : outAnimation,
                  child: child,
                );
              },
              child: Column(
                key: ValueKey(mostrarTurma),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mostrarTurma ? 'Técnico' : widget.diaHoje,
                    style: estiloTexto(15, peso: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    mostrarTurma ? 'Informática 2023' : widget.mes,
                    style: estiloTexto(15, peso: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => mostrarDialogoDeTrocaDeTema(
                          ctx,
                          temaProvider.temaAtivo.brightness == Brightness.light
                              ? "escuro"
                              : "claro"));
                },
                icon: Iconify(
                  temaProvider.temaAtivo.brightness == Brightness.light
                      ? Icones.lua
                      : Icones.sol,
                  size: 34,
                  color: temaProvider.corDosIcones(),
                )),
            if (!widget.icones)
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/notificacao');
                },
                icon: Iconify(
                  Icones.sino,
                  size: 34,
                  color: temaProvider.corDosIcones(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
