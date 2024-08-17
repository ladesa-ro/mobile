import "package:flutter/material.dart";
import "package:sisgha/app/constants/colors.dart";
import "package:sisgha/app/constants/estilos.dart";
import "package:sisgha/app/constants/tamanhotela.dart";
import "package:sisgha/app/views/perfil/widgets_perfil/widget_sair.dart";

Widget disponibilidade() {
  return LayoutBuilder(
    builder: (context, constraints) => Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Container(
            margin: tamanho(constraints.maxWidth),
            height: TamanhoTela.vertical(context) * 0.2,
            width: constraints.maxWidth,
            decoration: decoration(),
            child: Row(
              children: [
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('07:30 - 08:20', style: estilo()),
                    Text('08:20 - 09:10', style: estilo()),
                    Text('09:10 - 10:00', style: estilo()),
                    Text('10:20 - 11:10', style: estilo()),
                    Text('11:10 - 12:00', style: estilo()),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Matutino',
                      style: estiloTexto(18,
                          cor: ColorApp.VerdePrincipal, peso: FontWeight.bold),
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          Container(
            margin: tamanho(constraints.maxWidth),
            height: TamanhoTela.vertical(context) * 0.2,
            width: constraints.maxWidth,
            decoration: decoration(),
            child: Row(
              children: [
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('13:00 - 13:50', style: estilo()),
                    Text('13:50 - 14:40', style: estilo()),
                    Text('14:40 - 15:30', style: estilo()),
                    Text('15:50 - 16:40', style: estilo()),
                    Text('16:40 - 17:30', style: estilo()),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Vespertino',
                      style: estiloTexto(18,
                          cor: ColorApp.VerdePrincipal, peso: FontWeight.bold),
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          Container(
            margin: tamanho(constraints.maxWidth),
            height: TamanhoTela.vertical(context) * 0.2,
            width: constraints.maxWidth,
            decoration: decoration(),
            child: Row(
              children: [
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('19:00 - 19:50', style: estilo()),
                    Text('19:50 - 20:40', style: estilo()),
                    Text('20:40 - 21:30', style: estilo()),
                    Text('21:50 - 22:40', style: estilo()),
                    Text('22:40 - 23:30', style: estilo()),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Noturno',
                      style: estiloTexto(18,
                          cor: ColorApp.VerdePrincipal, peso: FontWeight.bold),
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widgetQuit(context),
            ],
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    ),
  );
}

EdgeInsets tamanho(double largura) {
  return EdgeInsets.only(
    bottom: 25,
    left: largura * 0.08,
    right: largura * 0.08,
  );
}

BoxDecoration decoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: ColorApp.CorFundoDisponibilidade,
  );
}

TextStyle estilo() {
  return estiloTexto(17, cor: ColorApp.VerdePrincipal, peso: FontWeight.bold);
}
