import 'package:flutter/material.dart';
import 'package:sisgha_mobile/pages/calendario/calendario.dart';
import 'package:sisgha_mobile/pages/home/home.dart';
import 'package:sisgha_mobile/pages/perfil/perfil.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(57, 160, 72, 1),
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconButton(Icons.home_filled, 0),
              _buildIconButton(Icons.person, 1),
              _buildIconButton(Icons.calendar_today_outlined, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return Center(
          child: Home(),
        );
      case 1:
        return Center(
          child: Perfil(),
        );
      case 2:
        return Center(
          child: Calendar(),
        );
      default:
        return Container();
    }
  }

  Widget _buildIconButton(IconData icon, int index) {
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
        child: Icon(
          icon,
          size: 35.0,
          color: _selectedIndex == index
              ? const Color.fromRGBO(57, 160, 72, 1)
              : Colors.white,
        ),
      ),
    );
  }
}
