import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../../../../core/utils/Icones.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/estilos.dart';

class WidgetDisponibilidade extends StatefulWidget {
  const WidgetDisponibilidade({super.key});

  @override
  State<WidgetDisponibilidade> createState() => _MyWidgetState();
}

final List<Map<String, dynamic>> horarios = [
  {
    "periodo": "Matutino",
    "horario": [
      "00:00 - 00:00",
      "00:00 - 00:00",
      "00:00 - 00:00",
      "00:00 - 00:00",
      "00:00 - 00:00",
    ]
  },
  {
    "periodo": "Vespertino",
    "horario": [
      "00:00 - 00:00",
      "00:00 - 00:00",
      "00:00 - 00:00",
      "00:00 - 00:00",
      "00:00 - 00:00",
    ]
  },
  {
    "periodo": "Noturno",
    "horario": [
      "00:00 - 00:00",
      "00:00 - 00:00",
      "00:00 - 00:00",
      "00:00 - 00:00",
      "00:00 - 00:00",
    ]
  },
];

class _MyWidgetState extends State<WidgetDisponibilidade> {
  List<String> dias = ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta'];
  int diaIndex = 0;

  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.11,
              decoration: BoxDecoration(
                color: ColorsTemaClaro.verdePrincipal,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  _iconButton(1, Icones.setaEsquerda),
                  const Spacer(),
                  Text(
                    dias[diaIndex],
                    style: estiloTexto(17,
                        cor: ColorsTemaClaro.brancoTexto,
                        peso: FontWeight.bold),
                  ),
                  const Spacer(),
                  _iconButton(0, Icones.setaDireita),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            CarouselSlider(
              carouselController: _carouselSliderController,
              items: _listaComHorarios(context),
              options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                height: constraints.maxHeight * 0.70,
                scrollPhysics: const NeverScrollableScrollPhysics(),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.04)
          ],
        ),
      ),
    );
  }

  void _alternarEntreDias(int direcao) {
    setState(
      () {
        if (direcao == 0 && diaIndex != 4) {
          diaIndex++;
          _carouselSliderController.animateToPage(diaIndex);
        }
        if (direcao == 1 && diaIndex != 0) {
          diaIndex--;
          _carouselSliderController.animateToPage(diaIndex);
        }
      },
    );
  }

  IconButton _iconButton(int index, String icone) {
    return IconButton(
      onPressed: () {
        _alternarEntreDias(index);
      },
      icon: Iconify(icone, color: ColorsTemaClaro.branco),
    );
  }
}

List<Widget> _listaComHorarios(context) {
  return List.generate(
    5,
    (index) => LayoutBuilder(
      builder: (context, constraints) => ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.45,
            width: constraints.maxWidth,
            child: _periodo(
                context, horarios[0]["periodo"], horarios[0]["horario"]),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: constraints.maxHeight * 0.45,
            width: constraints.maxWidth,
            child: _periodo(
                context, horarios[1]["periodo"], horarios[1]["horario"]),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: constraints.maxHeight * 0.45,
            width: constraints.maxWidth,
            child: _periodo(
                context, horarios[2]["periodo"], horarios[2]["horario"]),
          ),
        ],
      ),
    ),
  );
}

Widget _periodo(BuildContext context, String periodo, List<String> horas) {
  return Container(
    decoration: estiloBorda(cor: ColorsTemaClaro.verdecinzaBorda, radius: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            horas.length,
            (index) => Text(horas[index], style: _estilo()),
          ),
        ),
        Text(
          periodo,
          style: estiloTexto(16,
              cor: ColorsTemaClaro.pretoTexto, peso: FontWeight.bold),
        ),
      ],
    ),
  );
}

TextStyle _estilo() {
  return estiloTexto(16,
      cor: ColorsTemaClaro.pretoTexto, peso: FontWeight.w500);
}
