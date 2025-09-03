import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/core/utils/colors.dart';
import 'package:sisgha/core/utils/dias.dart';
import 'package:sisgha/core/utils/estilos.dart';
import 'package:sizer/sizer.dart';

import '../core/theme/tema_provider.dart';
import '../core/utils/icones.dart';
import '../core/utils/padroes.dart';
import 'dialogo_troca_de_tema.dart';
import '../viewmodels/escolha_horarios_alunos.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String mes;
  final String diaHoje;
  final bool icones;
  final bool animacaoAtiva;

  const CustomAppBar({
    super.key,
    required this.mes,
    required this.diaHoje,
    required this.icones,
    required this.animacaoAtiva,
  });

  @override
  Size get preferredSize => Size.fromHeight(9.h);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with TickerProviderStateMixin {
  late Timer _timer;
  bool _mostrarPrimeiro = true;

  @override
  void initState() {
    super.initState();

    if (widget.animacaoAtiva) {
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        setState(() {
          _mostrarPrimeiro = !_mostrarPrimeiro;
        });
      });
    } else {
      _timer = Timer(
        Duration.zero,
        () {},
      );
    }
  }

  @override
  void dispose() {
    _timer.cancel();
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
          child: Consumer<EscolhaHorariosAlunos>(
            builder: (context, pro, child) {
              return Row(
                children: [
                  if (widget.icones)
                    IconButton(
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/acessoAluno',
                          (route) => false,
                        );
                      },
                      icon: Iconify(
                        Icones.setaVoltarDireita,
                        size: 22.sp,
                        color: temaProvider.corDosIcones(),
                      ),
                      padding: const EdgeInsets.only(right: 20),
                    ),
                  buildTitulo(pro, widget.animacaoAtiva),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //em cima
                      buildSubtituloSuperior(pro, widget.animacaoAtiva),
                      //em baixo
                      buildSubtituloInferior(pro, widget.animacaoAtiva)
                    ],
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
                      size: 22.sp,
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
                        size: 22.sp,
                        color: temaProvider.corDosIcones(),
                      ),
                    ),
                ],
              );
            },
          )),
    );
  }

  Widget buildTitulo(EscolhaHorariosAlunos provider, bool animar) {
    if (animar) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: Text(
          _mostrarPrimeiro
              ? provider.turmaSelecionada ?? 'nao'
              : DatasFormatadas.diaAtual,
          style: estiloTexto(28),
          overflow: TextOverflow.ellipsis,
          key: ValueKey(_mostrarPrimeiro),
        ),
      );
    } else {
      return Text(DatasFormatadas.diaAtual,
          style:
              estiloTexto(28, cor: CoresClaras.branco, peso: FontWeight.bold));
    }
  }

  Widget buildSubtituloSuperior(EscolhaHorariosAlunos provider, bool animar) {
    if (animar) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: Text(
          _mostrarPrimeiro ? 'teste 2' : widget.diaHoje,
          style: estiloTexto(16),
          overflow: TextOverflow.ellipsis,
          key: ValueKey(_mostrarPrimeiro),
        ),
      );
    } else {
      return Text(widget.diaHoje,
          style:
              estiloTexto(16, cor: CoresClaras.branco, peso: FontWeight.bold));
    }
  }

  Widget buildSubtituloInferior(EscolhaHorariosAlunos provider, bool animar) {
    if (animar) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        child: Text(
          _mostrarPrimeiro
              ? 'teste 1'
              : '${DatasFormatadas.mesAtual} - ${DatasFormatadas.obterPrimeiroDiaSemana()} a ${DatasFormatadas.obterUltimoDiaSemana()}',
          style: estiloTexto(16),
          overflow: TextOverflow.ellipsis,
          key: ValueKey(_mostrarPrimeiro),
        ),
      );
    } else {
      return Text(
        '${DatasFormatadas.mesAtual} - ${DatasFormatadas.obterPrimeiroDiaSemana()} a ${DatasFormatadas.obterUltimoDiaSemana()}',
        style: estiloTexto(16, cor: CoresClaras.branco, peso: FontWeight.bold),
      );
    }
  }
}
