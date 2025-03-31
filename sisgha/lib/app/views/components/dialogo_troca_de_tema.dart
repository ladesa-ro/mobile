import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/data/providers/tema.dart';
import 'package:sizer/sizer.dart';

Widget mostrarDialogoDeTrocaDeTema(BuildContext context, String text) {
  final provider = Provider.of<TemasProvider>(context);
  bool temaAtual = provider.temaAtivo.brightness == Brightness.light;
  return AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 2.h),
        Iconify(
          temaAtual ? Icones.lua : Icones.sol,
          color: temaAtual ? CoresClaras.preto : CoresEscuras.brancoTextoEscuro,
          size: 3.h,
        ),
        SizedBox(height: 1.5.h),
        Text(
          "Modificar tema",
          style: estiloTexto(14, peso: FontWeight.bold),
        ),
        SizedBox(height: 0.5.h),
        Text(
          "Deseja modificar o tema para $text",
          style: estiloTexto(14,
              cor: CoresClaras.cinzatexto, peso: FontWeight.bold),
        ),
        SizedBox(height: 1.5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: _estiloBotao(temaAtual
                  ? CoresClaras.vermelhoBotao
                  : CoresEscuras.vermelhoBotaoEscuro),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Text(
                    "Não  ",
                    style: estiloTexto(14,
                        cor: temaAtual
                            ? CoresClaras.vermelhotexto
                            : CoresEscuras.vermelhoTextoEscuro,
                        peso: FontWeight.bold),
                  ),
                  Icon(
                    Icons.close,
                    color: temaAtual
                        ? CoresClaras.vermelhotexto
                        : CoresEscuras.vermelhoTextoEscuro,
                  ),
                ],
              ),
            ),
            SizedBox(width: 3.w),
            ElevatedButton(
              style: _estiloBotao(temaAtual
                  ? CoresClaras.verdePrincipal
                  : CoresEscuras.verdePrincipalEscuro),
              onPressed: () {
                provider.muldarTema();
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  Text(
                    "Sim  ",
                    style: estiloTexto(14,
                        cor: temaAtual
                            ? CoresClaras.verdePrincipalTexto
                            : CoresEscuras.verdePrincipalEscuro,
                        peso: FontWeight.bold),
                  ),
                  Icon(
                    Icons.done,
                    color: temaAtual
                        ? CoresClaras.verdePrincipalTexto
                        : CoresEscuras.verdePrincipalEscuro,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
      ],
    ),
  );
}

_estiloBotao(Color cor) {
  return ButtonStyle(
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.w),
          side: BorderSide(color: cor))));
}
