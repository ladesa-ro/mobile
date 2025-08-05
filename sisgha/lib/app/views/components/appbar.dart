import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/views/components/widgets_home/auto_font_size_text.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/icones.dart';
import '../../core/utils/estilos.dart';
import '../../core/utils/padroes.dart';
import '../../cache/tema.dart';
import '../components/widgets_home/appbar_animacoes.dart';
import 'dialogo_troca_de_tema.dart';
import '../../cache/escolha_horarios_alunos.dart';

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
    required this.animacaoAtiva,
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
    final provider = Provider.of<EscolhaHorariosAlunos>(context, listen: false);

    animacoes = AppBarAnimacoes(
      vsync: this,
      diaHoje: widget.diaHoje,
      mes: widget.mes,
      animacaoAtiva: widget.animacaoAtiva,
      onUpdate: () {
        setState(() {});
      },
      formacao: provider.nomeFormacaoSelecionada ?? '',
      curso: provider.cursoSelecionado ?? '', //
      turma: provider.turmaSelecionada ?? '',
    );
  }

  @override
  void dispose() {
    animacoes.dispose();
    super.dispose();
  }

// Preciso adicionar um comentário pq preciso dar commit
  Widget buildLinha1() {
    return SizedBox(
      height: 20,
      width: 160,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AutoFontSizeText(
            text: animacoes.linha1,
            style: estiloTexto(12.sp, peso: FontWeight.bold),
            maxWidth: constraints.maxWidth,
          );
        },
      ),
    );
  }

  Widget buildLinha2() {
    return SizedBox(
      height: 20,
      width: 160,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AutoFontSizeText(
            text: animacoes.linha2,
            style: estiloTexto(12.sp, peso: FontWeight.bold),
            maxWidth: constraints.maxWidth,
          );
        },
      ),
    );
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
                padding: const EdgeInsets.only(right: 20),
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
            const SizedBox(width: 5),
            SlideTransition(
              position: animacoes.slideSubTexto,
              child: FadeTransition(
                opacity: animacoes.fadeSubTexto,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLinha1(),
                    buildLinha2(),
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
