import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';

// ignore: non_constant_identifier_names
ElevatedButton BuildButtonEditPerfil(Color corFundo, Color corLapiz) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(corFundo),
      minimumSize: WidgetStateProperty.all(
        const Size(10, 28),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.all(5),
      ),
    ),
    onPressed: () => {},
    child: Iconify(
      Icones.Lapiz,
      size: 10,
      color: corLapiz,
    ),
  );
}
