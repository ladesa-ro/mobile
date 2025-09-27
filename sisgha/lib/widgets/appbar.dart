import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/core/theme/tema_provider.dart';
import 'package:sisgha/core/utils/colors.dart';
import 'package:sisgha/core/utils/dias.dart';
import 'package:sisgha/core/utils/estilos.dart';
import 'package:sisgha/core/utils/icones.dart';
import 'package:sisgha/core/utils/padroes.dart';
import 'package:sisgha/viewmodels/escolha_horarios_alunos.dart';
import 'package:sisgha/widgets/dialogo_troca_de_tema.dart';
import 'package:sizer/sizer.dart';

PreferredSizeWidget appBar(BuildContext ctx, EscolhaHorariosAlunos? provInfo) {
  var temaAtivo = Provider.of<TemasProvider>(ctx).temaAtivo.brightness;

  String verificarTemaAtivo() {
    if (temaAtivo == Brightness.light) return 'escuro';
    return 'claro';
  }

  return AppBar(
      toolbarHeight: 7.h,
      title: Container(
        color: CoresClaras.verdePrincipal,
        child: Row(
          children: [
            provInfo == null
                ? Padding(padding: EdgeInsets.only(left: 2.w))
                : IconButton(
                    onPressed: () {},
                    icon: _buildIcones(Icones.setaVoltarDireita, 23)),
            _buildInfo(),
            SizedBox(width: 2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_buildTitulo(), _buildSubtitulo()],
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: ctx,
                    builder: (context) => mostrarDialogoDeTrocaDeTema(
                        context, verificarTemaAtivo()),
                  );
                },
                icon: _buildIcones(Icones.sol, 22)),
            provInfo == null
                ? IconButton(
                    onPressed: () {
                      Navigator.of(ctx).pushNamed('/notificacao');
                    },
                    icon: _buildIcones(Icones.sino, 22))
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

Iconify _buildIcones(String icone, double size) {
  return Iconify(
    icone,
    color: CoresClaras.branco,
    size: size.sp,
  );
}
