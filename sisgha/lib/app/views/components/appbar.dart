import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';

import '../../core/utils/Icones.dart';
import '../../core/utils/dias.dart';
import '../../core/utils/estilos.dart';
import '../../core/utils/tamanhos.dart';
import '../../data/providers/tema.dart';
import 'dialogo_troca_de_tema.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String mes;
  final String diaHoje;

  final bool
      profOuAluno; //se for alunos colocar trur e se  for o professor colocar false

  const CustomAppBar(
      {super.key,
      required this.height,
      required this.mes,
      required this.diaHoje,
      required this.profOuAluno});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<TemasProvider>(context);
    return AppBar(
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: Tamanhos.margem(),
        child: Row(
          children: [
            if (profOuAluno == true)
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Iconify(
                  Icones.setaVoltarDireita,
                  size: 40,
                  color: temaProvider.corDosIcones(),
                ),
              ),
            Text(
              DatasFormatadas.diaAtual,
              style: estiloTexto(30, peso: FontWeight.bold),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diaHoje,
                  style: estiloTexto(17, peso: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  mes,
                  style: estiloTexto(17, peso: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (ctx) => mostrarDialogoDeTrocaDeTema(
                          ctx,
                          temaProvider.temaAtivo.brightness == Brightness.light
                              ? "escuro"
                              : "claro"));
                },
                icon: Iconify(
                  temaProvider.temaAtivo.brightness == Brightness.light
                      ? Icones.lua
                      : Icones.sol,
                  size: 34,
                  color: temaProvider.corDosIcones(),
                )),
            if (!profOuAluno)
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/notificacao');
                },
                icon: Iconify(
                  Icones.Sino,
                  size: 34,
                  color: temaProvider.corDosIcones(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
