// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../domain/api/repository.dart';
import '../../inicio/boas_vindas.dart';

Future widgetQuit(BuildContext context) async {
  if (await Repository.sair(context)) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const BoasVindasPage()),
      (Route<dynamic> route) => false,
    );
  }
}
