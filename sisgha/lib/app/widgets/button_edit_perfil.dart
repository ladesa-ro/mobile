import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';

// ignore: non_constant_identifier_names
ElevatedButton BuildButtonEditPerfil(
    Color corFundo, Color corLapiz, BuildContext context) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(corFundo),
      minimumSize: WidgetStateProperty.all(
        const Size(15, 25),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.all(5),
      ),
    ),
    onPressed: () => {_ShowbottonCheat(context)},
    child: Iconify(
      Icones.Lapiz,
      size: 15,
      color: corLapiz,
    ),
  );
}

// ignore: non_constant_identifier_names
void _ShowbottonCheat(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      height: 300,
      child: Column(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(255, 97, 97, 97),
              ),
              margin: const EdgeInsets.only(top: 20),
              height: 10,
              width: 100,
            ),
          )
        ],
      ),
    ),
  );
}
