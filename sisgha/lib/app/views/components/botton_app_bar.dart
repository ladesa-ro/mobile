import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/views/aluno/calendario/calendario_alunos.dart';
import 'package:sisgha/app/views/notificacao/notificacao.dart';

import 'package:sizer/sizer.dart';

import '../../core/utils/icones.dart';
import '../../core/utils/colors.dart';

import '../../core/utils/padroes.dart';
import '../../providers/escolha_calendario.dart';
import '../../domain/logic/verificar_token_ativo.dart';
import '../professor/calendario/calendario.dart';
import '../professor/home/home.dart';
import '../aluno/home_alunos.dart';
import '../professor/perfil/perfil.dart';

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
    BottomAppBar bottomAppBar = BottomAppBar(
      height: Padroes.alturaGeral() * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          construirBarraDeNavegacao(
              tokenAtivo: tokenAtivo, iconData: Icones.calendario, index: 0),
          construirBarraDeNavegacao(
              tokenAtivo: tokenAtivo, iconData: Icones.iconeSisgha, index: 1),
          construirBarraDeNavegacao(
              tokenAtivo: tokenAtivo,
              iconData: tokenAtivo ? Icones.usuario : null,
              iconify: tokenAtivo ? null : Icones.sino,
              index: 2),
        ],
      ),
    );

    return Scaffold(
        body: _buildPage(_selectedIndex, tokenAtivo),
        bottomNavigationBar: bottomAppBar);
  }

  Widget _buildPage(int index, bool tokenAtivo) {
    Widget page;

    if (tokenAtivo) {
      switch (index) {
        case 0:
          page = ChangeNotifierProvider(
            create: (_) => EscolhaCalendario(),
            child: Center(child: CalendarioProfessor()),
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
            child: Center(child: CalendarioAlunos()),
          );
          break;
        case 1:
          page = const Center(child: HomeAlunos());
          break;
        case 2:
          page = Center(child: Notificacao());
          break;
        default:
          page = const HomeAlunos();
      }
    }

    return page;
  }

  Widget construirBarraDeNavegacao(
      {String? iconify,
      IconData? iconData,
      required int index,
      required bool tokenAtivo}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: _decoretion(index),
        width: Padroes.larguraGeral() * 0.13,
        height: Padroes.alturaGeral() * 0.05,
        child: (iconData != null
            ? Icon(
                iconData,
                color: CoresClaras.branco,
                size: 3.h,
              )
            : Iconify(
                iconify!,
                size: 3.h,
                color: CoresClaras
                    .branco, // eu tirei os icon cheios pois n é mais preciso por causa das mudança de cores no prototipo
              )),
      ),
    );
  }

  bool verificarIndex(int index) {
    return _selectedIndex == index;
  }

  BoxDecoration _decoretion(int index) {
    return BoxDecoration(
      color: _selectedIndex == index ? CoresClaras.verdeClaro : null,
      borderRadius: BorderRadius.circular(Padroes.larguraGeral() * 0.03),
    );
  }
}
