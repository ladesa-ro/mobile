import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisgha/app/views/boasvindas.dart';

class Perfil extends StatelessWidget {
  const Perfil({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: IconButton(
            onPressed: () async {
              bool saiu = await sair();
              if (saiu) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BoasVindasPage(),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.logout_rounded,
              size: 40,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> sair() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    return true;
  }
}
