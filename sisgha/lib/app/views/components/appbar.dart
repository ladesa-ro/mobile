import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/utils/icones.dart';
import '../../core/utils/estilos.dart';
import '../../core/utils/padroes.dart';
import '../../providers/tema.dart';
import '../components/widgets_home/appbar_animacoes.dart';
import 'dialogo_troca_de_tema.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height;
  final String mes;
  final String diaHoje;
  final bool icones;
  final bool animacaoAtiva;

  const CustomAppBar({
    super.key,
    required this.height,
    required this.mes,
    required this.diaHoje,
    required this.icones,
    required this.animacaoAtiva, // se for na appbar dos alunos deixa como tru e dos prof false 
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  late AppBarAnimacoes animacoes;

  @override
  void initState() {
    super.initState();
    animacoes = AppBarAnimacoes(
      vsync: this,
      diaHoje: widget.diaHoje,
      mes: widget.mes,
      animacaoAtiva: widget.animacaoAtiva,
      onUpdate: () {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    animacoes.dispose();
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
            SlideTransition(
              position: animacoes.slideTextoPrincipal,
              child: FadeTransition(
                opacity: animacoes.fadeTextoPrincipal,
                child: Text(
                  animacoes.textoPrincipal,
                  style: estiloTexto(30, peso: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 16),
            SlideTransition(
              position: animacoes.slideSubTexto,
              child: FadeTransition(
                opacity: animacoes.fadeSubTexto,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animacoes.linha1,
                      style: estiloTexto(16, peso: FontWeight.bold),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      animacoes.linha2,
                      style: estiloTexto(16, peso: FontWeight.bold),
                    ),
                  ],
                ),
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
                        : "claro",
                  ),
                );
              },
              icon: Iconify(
                temaProvider.temaAtivo.brightness == Brightness.light
                    ? Icones.lua
                    : Icones.sol,
                size: 34,
                color: temaProvider.corDosIcones(),
              ),
            ),
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
              ),
          ],
        ),
      ),
    );
  }
}
