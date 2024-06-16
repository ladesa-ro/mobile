import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/views/calendario/calendario.dart';
import 'package:sisgha/app/views/home/home.dart';
import 'package:sisgha/app/views/perfil/perfil.dart';

class Navigation extends StatefulWidget {
  final int initialIndex;

  const Navigation({Key? key, required this.initialIndex}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        height: TamanhoTela.vertical(context) > 810 ? 65 : 60,
        color: ColorApp.VerdePrincipal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildIconButton(
                iconVazio: Icones.HomeVazio,
                iconCheio: Icones.HomeCheio,
                index: 0),
            _buildIconButton(
                iconVazio1: Icones.PersonVazio,
                iconCheio1: Icones.PersonCheio,
                index: 1),
            _buildIconButton(
                iconVazio1: Icones.CalendarVazio,
                iconCheio1: Icones.CalendarCheio,
                index: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const Center(
          child: Home(),
        );
      case 1:
        return const Center(
          child: Perfil(),
        );
      case 2:
        return const Center(
          child: Calendar(),
        );
      default:
        return Container();
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
          color: _selectedIndex == index ? Colors.white : null,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 60,
        height: 50,
        child: _selectedIndex == index
            ? (iconCheio1 != null
                ? Icon(
                    iconCheio1,
                    color: ColorApp.VerdePrincipal,
                    size: 30,
                  )
                : Iconify(
                    iconCheio!,
                    size: 20,
                    color: ColorApp.VerdePrincipal,
                  ))
            : (iconVazio1 != null
                ? Icon(
                    iconVazio1,
                    color: ColorApp.Branco,
                    size: 30,
                  )
                : Iconify(
                    iconVazio!,
                    size: 20,
                    color: ColorApp.Branco,
                  )),
      ),
    );
  }
}
