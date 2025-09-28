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

PreferredSizeWidget appBar(BuildContext ctx) {
  var temaAtivo = Provider.of<TemasProvider>(ctx).temaAtivo.brightness;

  String verificarTemaAtivo() {
    if (temaAtivo == Brightness.light) return 'escuro';
    return 'claro';
  }

  return AppBar(
      toolbarHeight: 7.h,
      title: Container(
        color: CoresClaras.verdePrincipal,
        child: Consumer<EscolhaHorariosAlunos?>(
            builder: (context, provInfo, child) {
          bool existeInfo = provInfo != null;
          bool existeSelecionado =
              existeInfo ? provInfo.idFormacaoSelecionada == null : false;
          return Row(
            children: [
              existeSelecionado
                  ? Padding(padding: EdgeInsets.only(left: 2.w))
                  : IconButton(
                      onPressed: () {
                        provInfo!.resetarEscolhas();
                        Navigator.of(ctx).pushNamedAndRemoveUntil(
                            '/acessoAluno', (_) => false);
                      },
                      icon: _buildIcones(Icones.setaVoltarDireita, 23)),
              _buildInfo(provInfo),
              SizedBox(width: 2.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitulo(provInfo, existeSelecionado),
                  existeSelecionado ? _buildSubtitulo() : Container()
                ],
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
              existeSelecionado
                  ? IconButton(
                      onPressed: () {
                        Navigator.of(ctx).pushNamed('/notificacao');
                      },
                      icon: _buildIcones(Icones.sino, 22))
                  : Container()
            ],
          );
        }),
      ));
}

Widget _buildInfo(EscolhaHorariosAlunos? provInfo) {
  final texto = provInfo?.turmaSelecionada ?? DatasFormatadas.diaAtual;
  final textoSeparado = Padroes.separarTexto(texto);

  dynamic mostrar = textoSeparado.isEmpty ? texto : textoSeparado;

  return SizedBox(
    child: textoSeparado.isEmpty
        ? Text(
            texto,
            style: estiloTexto(27,
                cor: CoresClaras.brancoTexto, peso: FontWeight.bold),
            maxLines: 2,
          )
        : Column(
            //apresentar na reunião se vão gostar da ideia, se sim qual a orientação que vai ficar
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mostrar[0],
                  style: estiloTexto(18,
                      cor: CoresClaras.brancoTexto, peso: FontWeight.bold)),
              Text(mostrar[1],
                  style: estiloTexto(18,
                      cor: CoresClaras.brancoTexto, peso: FontWeight.bold))
            ],
          ),
  );
}

Widget _buildTitulo(EscolhaHorariosAlunos? provInfo, bool existeSelecionado) {
  final texto = existeSelecionado
      ? DatasFormatadas.diaExtenso
      : '${provInfo!.nomeFormacaoSelecionada} - ${DatasFormatadas.anoAtual}';
  return SizedBox(
    width: existeSelecionado ? null : 50.w,
    child: Text(
      Padroes.primeiraLetraMaiuscula(texto),
      style:
          estiloTexto(16, cor: CoresClaras.brancoTexto, peso: FontWeight.bold),
      maxLines: 2,
    ),
  );
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
