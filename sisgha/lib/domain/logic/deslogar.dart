// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../repository/repository.dart';
import '../../views/login/boas_vindas.dart';

Future widgetQuit(BuildContext context) async {
  if (await Repository.sair(context)) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const BoasVindasPage()),
      (Route<dynamic> route) => false,
    );
  }
}
