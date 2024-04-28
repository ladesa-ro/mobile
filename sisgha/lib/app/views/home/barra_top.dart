import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/dias.dart';

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
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(12),
              child: Text(DatasFormatadas.DiaAgora,
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${DatasFormatadas.DiaExtensoFormatado[0].toUpperCase() + DatasFormatadas.DiaExtensoFormatado.substring(1)}${DatasFormatadas.DiaExtensoFormatado == 'sabado' || DatasFormatadas.DiaExtensoFormatado == 'domingo' ? '' : 'Feira'}'),
                Text(
                  '${DatasFormatadas.MesAgora[0].toUpperCase() + DatasFormatadas.MesAgora.substring(1)} - Dia 12 a 16',
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
