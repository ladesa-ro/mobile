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
              itemCount: 2,
              itemBuilder: (context, index) => Column(
                children: [
                  cards(context,
                      titulo: 'Funciona $index',
                      menssagem:
                          'O Lorem Ipsum é um texto modelo da indústria tipográfica e de impressão.',
                      link: 'clique aqui e confira',
                      icon: Icones.Sino,
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
            Iconify(
              icon,
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
