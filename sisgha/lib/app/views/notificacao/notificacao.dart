import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';

import 'package:sisgha/app/views/components/appbar_notificacao.dart';
import 'package:sizer/sizer.dart';

class Notificacao extends StatelessWidget {
  const Notificacao({super.key});
  static final List<ItensNotificacoes> notificacoes = [
    ItensNotificacoes(
      icone: Icones.CalendarVazio,
      titulo: "Novo evento!",
      tempo: "2 dias",
      texto: "O evento IFRO Party foi agendado para o dia 10 de setembro",
      link: "Clique aqui e confira",
    ),
    ItensNotificacoes(
      icone: Icones.IconeSisgha,
      titulo: "Novo horário",
      tempo: "5 dias",
      texto: "A aula das 13h de Filosofia II foi cancelada, aula vaga",
      link: "Clique aqui e confira",
    ),
    ItensNotificacoes(
      icone: Icones.IconeSisgha,
      titulo: "Alteração no horário",
      tempo: "15 dias",
      texto: "A aula de Filosofia II foi trocada pela aula de Banco de Dados I",
      link: "Clique aqui e confira",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final appBar = CustomAppBarNotificacao(height: 6.h, seta: true);

    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Flexible(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: notificacoes.length,
              itemBuilder: (context, index) => Column(
                children: [
                  cards(context,
                      titulo: notificacoes[index].titulo,
                      menssagem: notificacoes[index].texto,
                      link: notificacoes[index].link,
                      icon: Icones.Sino,
                      data: notificacoes[index].tempo),
                  Divider(
                    thickness: 1.5,
                    color: CoresClaras.verdecinzaBorda,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget cards(BuildContext context,
    {required String titulo,
    required String menssagem,
    required dynamic link,
    required dynamic icon,
    required String data}) {
  return Padding(
    padding: EdgeInsets.only(
        left: Tamanhos.margem(context).left,
        right: Tamanhos.margem(context).right,
        top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Iconify(
              icon,
              size: 30,
              color: CoresClaras.verdePrincipal,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              titulo,
              style: estiloTexto(15,
                  cor: CoresClaras.verdePrincipalTexto, peso: FontWeight.bold),
            ),
            Spacer(),
            Text(
              data,
              style: estiloTexto(14, cor: CoresClaras.verdecinzaTexto),
            )
          ],
        ),
        SizedBox(height: 10),
        Text(menssagem, style: estiloTexto(14, cor: CoresClaras.preto)),
        TextButton(
          style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
          onPressed: () {},
          child: Text(
            link,
            style: estiloTexto(14, cor: CoresClaras.verdePrincipal),
          ),
        ),
      ],
    ),
  );
}

class ItensNotificacoes {
  final IconData icone;
  final String titulo;
  final String tempo;
  final String texto;
  final String link;

  ItensNotificacoes({
    required this.icone,
    required this.titulo,
    required this.tempo,
    required this.texto,
    required this.link,
  });
}
