import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/Icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/estilos.dart';
import '../../../core/utils/tamanhos.dart';
import '../calendario.dart';

Widget botaoMiniCalendario(BuildContext context) {
  DateTime now = DateTime.now();
  return ElevatedButton(
    style: Tamanhos.estiloBotao(),
    onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const MiniCalendario(
            showDialog: true,
          );
        },
      );
    },
    child: Row(
      children: [
        const SizedBox(
          width: 16,
        ),
        Icon(
          Icones.CalendarVazio,
          size: 3.h,
          color: CoresClaras.branco,
        ),
        const Spacer(),
        Text(
          'Calendário ${now.year}',
          style: estiloTexto(15,
              cor: CoresClaras.brancoTexto, peso: FontWeight.bold),
        ),
        const Spacer(),
        Iconify(
          Icones.SetaBaixo,
          size: 4.h,
          color: CoresClaras.branco,
        ),
        const SizedBox(
          width: 16,
        )
      ],
    ),
  );
}
