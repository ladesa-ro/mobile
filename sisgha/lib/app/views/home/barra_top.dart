import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  CustomAppBar({required this.height});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: ColorApp.Branco,
      title: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                DatasFormatadas.DiaAgora,
                style: estiloTexto(
                  TamanhoTela.horizontal(context) < 400 ? 45 : 50,
                  cor: ColorApp.Branco,
                  peso: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              width: TamanhoTela.horizontal(context) * 0.04,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DatasFormatadas.DiaExtensoFormatado[0].toUpperCase() + DatasFormatadas.DiaExtensoFormatado.substring(1)}${DatasFormatadas.DiaExtensoFormatado == 'sabado' || DatasFormatadas.DiaExtensoFormatado == 'domingo' ? '' : 'Feira'}',
                  style: estiloTexto(
                    TamanhoTela.horizontal(context) < 400 ? 21 : 23,
                    cor: ColorApp.Branco,
                  ),
                ),
                Text(
                  '${DatasFormatadas.MesAgora[0].toUpperCase() + DatasFormatadas.MesAgora.substring(1)} - Dia 12 a 16',
                  style: estiloTexto(
                    TamanhoTela.horizontal(context) < 400 ? 21 : 23,
                    cor: ColorApp.Branco,
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Iconify(
                    Icones.Bell,
                    size: 40,
                    color: ColorApp.Branco,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
