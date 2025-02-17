import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/responsividade.dart';
import 'package:sisgha/app/views/calendario/calendario.dart';
import 'package:sisgha/app/views/home/home.dart';
import 'package:sisgha/app/views/perfil/perfil.dart';
import 'package:sizer/sizer.dart';

import '../../data/providers/escolha_menu_lateral.dart';

class NavigationAlunos extends StatefulWidget {
  final int initialIndex;

  const NavigationAlunos({super.key, required this.initialIndex});

  @override
  State<NavigationAlunos> createState() => _NavigationState();
}

class _NavigationState extends State<NavigationAlunos> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    BottomAppBar bottomAppBarAluno = BottomAppBar(
      height: TamanhoTela.vertical(context) * 0.08,
      color: ColorsTemaClaro.verdePrincipal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconButton(
              iconVazio1: Icones.CalendarVazio,
              iconCheio1: Icones.CalendarCheio,
              index: 0),
          _buildIconButton(
              iconVazio1: Icones.IconeSisgha,
              iconCheio1: Icones.IconeSisgha,
              index: 1),
          _buildIconButton(
              iconVazio1: Icones.PersonVazio,
              iconCheio1: Icones.PersonCheio,
              index: 2),
        ],
      ),
    );

    return Scaffold(
        body: _buildPage(_selectedIndex), bottomNavigationBar: bottomAppBarAluno);
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return ChangeNotifierProvider(
          create: (_) => EscolhaCalendario(),
          child: Center(
            child: Calendar(),
          ),
        );
      case 1:
        return const Center(
          child: Home(),
        );
      case 2:
        return const Center(
          child: Perfil(),
        );
      default:
        return const Home();
    }
  }

  Widget _buildIconButton({
    String? iconVazio,
    String? iconCheio,
    IconData? iconVazio1,
    IconData? iconCheio1,
    required int index,
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
        decoration: BoxDecoration(
          color: _selectedIndex == index ? ColorsTemaClaro.branco : null,
          borderRadius:
              BorderRadius.circular(TamanhoTela.horizontal(context) * 0.03),
        ),
        width: TamanhoTela.horizontal(context) * 0.13,
        height: TamanhoTela.vertical(context) * 0.05,
        child: _selectedIndex == index
            ? (iconCheio1 != null
                ? Icon(
                    iconCheio1,
                    color: ColorsTemaClaro.verdePrincipal,
                    size: 3.h,
                  )
                : Iconify(
                    iconCheio!,
                    size: 3.h,
                    color: ColorsTemaClaro.verdePrincipal,
                  ))
            : (iconVazio1 != null
                ? Icon(
                    iconVazio1,
                    color: ColorsTemaClaro.branco,
                    size: 3.h,
                  )
                : Iconify(
                    iconVazio!,
                    size: 3.h,
                    color: ColorsTemaClaro.branco,
                  )),
      ),
    );
  }
}
