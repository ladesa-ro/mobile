import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';

import 'package:sisgha/app/views/widgets_globais/appbar_notificacao_aluno.dart';
import 'package:sizer/sizer.dart';

class Notificacao extends StatelessWidget {
  const Notificacao({super.key});

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
              itemCount: 1,
              itemBuilder: (context, index) => Column(
                children: [
                  cards(context,
                      titulo: 'Novo horário!',
                      menssagem:
                          'A aula das 13h de Filosofia II foi cancelada, aula vaga',
                      link: 'Clique aqui e confira',
                      icon: Icones.IconeSisgha, // Passe apenas a String
                      data: '$index dias'),
                  Divider(
                    thickness: 1.5,
                    color: ColorsTemaClaro.verdecinzaBorda,
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
            Icon(
              icon, // Aqui, 'icon' é um IconData agora
              size: 30,
              color: ColorsTemaClaro.verdePrincipal,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              titulo,
              style: estiloTexto(15,
                  cor: ColorsTemaClaro.verdePrincipalTexto,
                  peso: FontWeight.bold),
            ),
            Spacer(),
            Text(
              data,
              style: estiloTexto(14, cor: ColorsTemaClaro.verdecinzaTexto),
            )
          ],
        ),
        SizedBox(height: 10),
        Text(menssagem, style: estiloTexto(14, cor: ColorsTemaClaro.preto)),
        TextButton(
          style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
          onPressed: () {},
          child: Text(
            link,
            style: estiloTexto(14, cor: ColorsTemaClaro.verdePrincipal),
          ),
        ),
      ],
    ),
  );
}
