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
  bool mostrarTurma = false;

  late AnimationController _controllerTextoPrincipal;
  late Animation<Offset> _slideTextoPrincipal;
  late Animation<double> _fadeTextoPrincipal;
  String _textoPrincipal = '';

  late AnimationController _controllerSubTexto;
  late Animation<Offset> _slideSubTexto;
  late Animation<double> _fadeSubTexto;
  String _linha1 = '';
  String _linha2 = '';

  Timer? _timer;

  @override
  @override
  void initState() {
    super.initState();

    _textoPrincipal = DatasFormatadas.diaAtual;
    _linha1 = widget.diaHoje;
    _linha2 = widget.mes;

    _controllerTextoPrincipal = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideTextoPrincipal = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(CurvedAnimation(
        parent: _controllerTextoPrincipal, curve: Curves.easeInOut));
    _fadeTextoPrincipal = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        parent: _controllerTextoPrincipal, curve: Curves.easeInOut));

    _controllerSubTexto = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideSubTexto = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1),
    ).animate(
        CurvedAnimation(parent: _controllerSubTexto, curve: Curves.easeInOut));
    _fadeSubTexto = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
        CurvedAnimation(parent: _controllerSubTexto, curve: Curves.easeInOut));

    if (widget.animacaoAtiva) {
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        if (mounted) {
          _trocarTextos();
        }
      });
    }
  }

  Future<void> _trocarTextos() async {
    if (!widget.animacaoAtiva) return; 

    await Future.wait([
      _controllerTextoPrincipal.forward(),
      _controllerSubTexto.forward(),
    ]);

    setState(() {
      mostrarTurma = !mostrarTurma;

      _textoPrincipal = mostrarTurma ? '1°A' : DatasFormatadas.diaAtual;
      _linha1 = mostrarTurma ? 'Técnico' : widget.diaHoje;
      _linha2 = mostrarTurma ? 'Informática 2023' : widget.mes;
    });

    _controllerTextoPrincipal.reset();
    _controllerSubTexto.reset();

    await Future.delayed(const Duration(milliseconds: 50));

    await Future.wait([
      _controllerTextoPrincipal.reverse(),
      _controllerSubTexto.reverse(),
    ]);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controllerTextoPrincipal.dispose();
    _controllerSubTexto.dispose();
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
              position: _slideTextoPrincipal,
              child: FadeTransition(
                opacity: _fadeTextoPrincipal,
                child: Text(
                  _textoPrincipal,
                  style: estiloTexto(30, peso: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 16),
            SlideTransition(
              position: _slideSubTexto,
              child: FadeTransition(
                opacity: _fadeSubTexto,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _linha1,
                      style: estiloTexto(16, peso: FontWeight.bold),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      _linha2,
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
