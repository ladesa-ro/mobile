import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/core/utils/colors.dart';
import 'package:sisgha/core/utils/dias.dart';
import 'package:sisgha/core/utils/estilos.dart';
import 'package:sisgha/core/utils/icones.dart';
import 'package:sisgha/core/utils/padroes.dart';
import 'package:sisgha/viewmodels/escolha_horarios_alunos.dart';
import 'package:sizer/sizer.dart';

PreferredSizeWidget appBar(BuildContext ctx, EscolhaHorariosAlunos? provInfo) {
  return AppBar(
      toolbarHeight: 7.h,
      title: Container(
        color: CoresClaras.verdePrincipal,
        child: Row(
          children: [
            provInfo == null
                ? Container()
                : IconButton(
                    onPressed: () {}, icon: Iconify(Icones.setaVoltarDireita)),
            SizedBox(width: 2.w),
            _buildInfo(),
            SizedBox(width: 2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_buildTitulo(), _buildSubtitulo()],
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: Iconify(Icones.sol)),
            provInfo == null
                ? IconButton(
                    onPressed: () {
                      Navigator.of(ctx).pushNamed('/notificacao');
                    },
                    icon: Iconify(Icones.sino))
                : Container()
          ],
        ),
      ));
}

Widget _buildInfo() {
  return Text(
    DatasFormatadas.diaAtual,
    style: estiloTexto(27, cor: CoresClaras.brancoTexto, peso: FontWeight.bold),
  );
}

Widget _buildTitulo() {
  final String dia = DatasFormatadas.diaExtenso;
  return Text(Padroes.primeiraLetraMaiuscula(dia),
      style:
          estiloTexto(16, cor: CoresClaras.brancoTexto, peso: FontWeight.bold));
}

Widget _buildSubtitulo() {
  final String mes = DatasFormatadas.mesAtual;
  final String primDia = DatasFormatadas.obterPrimeiroDiaSemana();
  final String ultDia = DatasFormatadas.obterUltimoDiaSemana();

  return Text('${Padroes.primeiraLetraMaiuscula(mes)} - Dia $primDia a $ultDia',
      style:
          estiloTexto(16, cor: CoresClaras.brancoTexto, peso: FontWeight.bold));
}
