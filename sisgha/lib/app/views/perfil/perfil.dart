import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/views/inicio/boasvindas.dart';
import 'package:sisgha/app/widgets/builder_perfil.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const FutureBuilderPerfil(),
    );
  }
}
