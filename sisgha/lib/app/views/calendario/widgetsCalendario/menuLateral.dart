import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sizer/sizer.dart';

Widget headerDrawer(BuildContext context, double height, double width) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    height: height * 0.1,
    width: width,
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Calendário Parcial',
              style: estiloTexto(16,
                  cor: ColorApp.VerdePrincipal, peso: FontWeight.bold),
            ),
            Text(
              'Selecione as informações',
              style: estiloTexto(15,
                  cor: ColorApp.CinzaEscuro, peso: FontWeight.bold),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Iconify(
            Icones.setaVoltar,
            color: ColorApp.VerdePrincipal,
            size: 5.h,
          ),
        )
      ],
    ),
  );
}

Widget quadradoAnoLetivo(
    BuildContext context, double width, String text, bool selecionado) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
    margin: EdgeInsets.only(right: width * 0.02),
    decoration: BoxDecoration(
        color: selecionado
            ? const Color.fromARGB(113, 115, 185, 124)
            : ColorApp.PretoClaroBotao,
        border: Border.all(
          color:
              selecionado ? ColorApp.VerdePrincipalBorda : Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10)),
    child: Text(
      text,
      style: estiloTexto(14,
          cor:
              selecionado ? ColorApp.VerdePrincipal : ColorApp.VerdeCinzaTexto),
    ),
  );
}

Widget quadradoModalidades(bool selecionado, String nome, double width) {
  return AnimatedContainer(
    padding:
        EdgeInsets.symmetric(horizontal: width * 0.05, vertical: width * 0.03),
    duration: Duration(milliseconds: 300),
    decoration: BoxDecoration(
      border: Border.all(
          color:
              selecionado ? ColorApp.VerdePrincipalBorda : Colors.transparent),
      borderRadius: BorderRadius.circular(10),
      color: selecionado
          ? const Color.fromARGB(113, 115, 185, 124)
          : ColorApp.PretoClaroBotao,
    ),
    child: Text(
      nome,
      style: estiloTexto(14,
          cor: selecionado
              ? ColorApp.VerdePrincipalTexto
              : ColorApp.VerdeCinzaTexto),
    ),
  );
}
