import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
