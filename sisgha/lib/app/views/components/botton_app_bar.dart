import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/views/aluno/calendario_alunos/calendario_alunos.dart';
import 'package:sisgha/app/views/notificacao/notificacao.dart';

import 'package:sizer/sizer.dart';

import '../../core/utils/Icones.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/responsividade.dart';
import '../../data/providers/escolha_menu_lateral.dart';
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
      height: TamanhoTela.vertical(context) * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          construirBarraDeNavegacao(
              tokenAtivo: tokenAtivo,
              iconVazio1: Icones.CalendarVazio,
              iconCheio1: Icones.CalendarCheio,
              index: 0),
          construirBarraDeNavegacao(
              tokenAtivo: tokenAtivo,
              iconVazio1: Icones.IconeSisgha,
              iconCheio1: Icones.IconeSisgha,
              index: 1),
          construirBarraDeNavegacao(
              tokenAtivo: tokenAtivo,
              iconVazio1: tokenAtivo ? Icones.PersonVazio : null,
              iconCheio1: tokenAtivo ? Icones.PersonCheio : null,
              iconCheio: tokenAtivo ? null : Icones.Sino,
              iconVazio: tokenAtivo ? null : Icones.Sino,
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
            child: Center(child: CalendarAlunos()),
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
      {String? iconVazio,
      String? iconCheio,
      IconData? iconVazio1,
      IconData? iconCheio1,
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
        width: TamanhoTela.horizontal(context) * 0.13,
        height: TamanhoTela.vertical(context) * 0.05,
        child: verificarIndex(index)
            ? (iconCheio1 != null
                ? Icon(
                    iconCheio1,
                    color: CoresClaras.verdePrincipal,
                    size: 3.h,
                  )
                : Iconify(
                    iconCheio!,
                    size: 3.h,
                    color: CoresClaras.verdePrincipal,
                  ))
            : (iconVazio1 != null
                ? Icon(
                    iconVazio1,
                    color: CoresClaras.branco,
                    size: 3.h,
                  )
                : Iconify(
                    iconVazio!,
                    size: 3.h,
                    color: CoresClaras.branco,
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
      borderRadius:
          BorderRadius.circular(TamanhoTela.horizontal(context) * 0.03),
    );
  }
}
