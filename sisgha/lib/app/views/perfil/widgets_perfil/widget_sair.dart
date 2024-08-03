import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/views/inicio/boasvindas.dart';

ElevatedButton widgetQuit(BuildContext context) {
  return ElevatedButton(
    style: _estiloBotao(),
    onPressed: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const BoasVindasPage()),
        (Route<dynamic> route) => false,
      );
    },
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icones.Sair),
        SizedBox(
          width: 10,
        ),
        Text("Sair"),
      ],
    ),
  );
}

ButtonStyle _estiloBotao() {
  return ButtonStyle(
    foregroundColor: const WidgetStatePropertyAll(ColorApp.Branco),
    fixedSize: const WidgetStatePropertyAll(
      Size(125, 55),
    ),
    backgroundColor: const WidgetStatePropertyAll(ColorApp.VermelhoFechado),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
    ),
  );
}
