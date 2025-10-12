import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/views/aluno/calendario/calendario_alunos.dart';
import 'package:sisgha/views/aluno/notificacao/notificacao.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/icones.dart';
import '../../core/utils/padroes.dart';
import '../../viewmodels/escolha_calendario.dart';
import '../../domain/logic/verificar_token_ativo.dart';
import '../professor/calendario/calendario.dart';
import '../professor/home/home.dart';
import '../aluno/home_alunos.dart';
import '../professor/perfil/perfil.dart';
import 'app_bar/appbar_principal.dart';

class Navigation extends StatefulWidget {
  final int initialIndex;

  const Navigation({super.key, required this.initialIndex});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late int _selectedIndex;
  bool tokenAtivo = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    verificarTokenAtivo().then((retorno) {
      setState(() {
        tokenAtivo = retorno;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    BottomAppBar bottomAppBar = BottomAppBar(
      color: tema.primaryContainer,
      height: Padroes.alturaGeral() * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          construirBarraDeNavegacao(
              tokenAtivo: tokenAtivo,
              iconData: Icones.calendario,
              index: 0,
              tema: tema),
          construirBarraDeNavegacao(
              tokenAtivo: tokenAtivo,
              iconData: Icones.iconeSisgha,
              index: 1,
              tema: tema),
          construirBarraDeNavegacao(
              tokenAtivo: tokenAtivo,
              iconData: tokenAtivo ? Icones.usuario : null,
              iconify: tokenAtivo ? null : Icones.sino,
              index: 2,
              tema: tema),
        ],
      ),
    );

    return Scaffold(
      appBar: _selectedIndex != 2 ? appBar(context) : null,
      body: _buildPage(_selectedIndex, tokenAtivo),
      bottomNavigationBar: bottomAppBar,
    );
  }

  Widget _buildPage(int index, bool tokenAtivo) {
    Widget page;

    if (tokenAtivo) {
      switch (index) {
        case 0:
          page = ChangeNotifierProvider(
            create: (_) => EscolhaCalendario(),
            child: const Center(child: CalendarioProfessor()),
          );
          break;
        case 1:
          page = const Center(child: Home());
          break;
        case 2:
          page = const Center(child: Perfil());
          break;
        default:
          page = const Home();
      }
    } else {
      switch (index) {
        case 0:
          page = ChangeNotifierProvider(
            create: (_) => EscolhaCalendario(),
            child: const Center(child: CalendarioAlunos()),
          );
          break;
        case 1:
          page = const Center(child: HomeAlunos());
          break;
        case 2:
          page = Notificacao(
            voltarProfessores: false,
          );
          break;
        default:
          page = const HomeAlunos();
      }
    }

    return page;
  }

  Widget construirBarraDeNavegacao({
    String? iconify,
    IconData? iconData,
    required int index,
    required bool tokenAtivo,
    required ColorScheme tema,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: _decoretion(index, tema),
        width: Padroes.larguraGeral() * 0.13,
        height: Padroes.alturaGeral() * 0.05,
        child: iconData != null
            ? Icon(
                iconData,
                color: tema.primaryFixed,
                size: 3.h,
              )
            : Iconify(
                iconify!,
                size: 3.h,
                color: tema.primaryFixed,
              ),
      ),
    );
  }

  bool verificarIndex(int index) {
    return _selectedIndex == index;
  }

  BoxDecoration _decoretion(int index, ColorScheme tema) {
    return BoxDecoration(
      color: _selectedIndex == index ? tema.secondaryContainer : null,
      borderRadius: BorderRadius.circular(Padroes.larguraGeral() * 0.03),
    );
  }
}
