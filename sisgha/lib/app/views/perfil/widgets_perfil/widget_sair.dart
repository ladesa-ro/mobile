import 'package:flutter/material.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/views/inicio/boasvindas.dart';

Future widgetQuit(BuildContext context) async {
  if (await sair()) {
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const BoasVindasPage()),
      (Route<dynamic> route) => false,
    );
  }
}
