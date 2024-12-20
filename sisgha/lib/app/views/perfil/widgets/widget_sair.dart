// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../data/api/repository.dart';
import '../../inicio/boas_vindas.dart';

Future widgetQuit(BuildContext context) async {
  if (await sair()) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const BoasVindasPage()),
      (Route<dynamic> route) => false,
    );
  }
}
