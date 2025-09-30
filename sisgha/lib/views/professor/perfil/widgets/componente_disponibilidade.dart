import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/icones.dart';
import '../../../../core/utils/cores.dart';
import '../../../../core/utils/estilos.dart';
import '../../../../core/utils/padroes.dart';

class WidgetDisponibilidade extends StatefulWidget {
  const WidgetDisponibilidade({super.key});

  @override
  State<WidgetDisponibilidade> createState() => _MyWidgetState();
}

//Vou adicionar uns comentários aqui para ficar mais fácil de entender o código.
//Pelo menos pra eu entender.

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
]; //HORÁRIOS

class _MyWidgetState extends State<WidgetDisponibilidade> {
  List<String> dias = ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta'];
  int diaIndex = 0;

  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.11,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _iconButton(1, Icones.setaEsquerda, tema),
                const Spacer(),
                Text(
                  dias[diaIndex],
                  style:
                      estiloTexto(17, cor: tema.primary, peso: FontWeight.bold),
                ),
                const Spacer(),
                _iconButton(0, Icones.setaDireita, tema),
              ],
            ),
          ),
          Expanded(
            child: CarouselSlider(
              carouselController: _carouselSliderController,
              items: _listaComHorarios(context, tema),
              options: CarouselOptions(
                aspectRatio: 16 / 12,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                scrollPhysics: const NeverScrollableScrollPhysics(),
              ), //Este é os coiso onde aparece os horários
            ),
          ),
        ],
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

  IconButton _iconButton(int index, String icone, ColorScheme tema) {
    return IconButton(
      onPressed: () {
        _alternarEntreDias(index);
      },
      icon: Iconify(icone, color: tema.surfaceDim),
    );
  }
}

List<Widget> _listaComHorarios(BuildContext context, ColorScheme tema) {
  return List.generate(
    5,
    (index) => LayoutBuilder(
      builder: (context, constraints) => ListView(
        shrinkWrap: true,
        physics: Padroes.efeitoDeRolagem(),
        padding: EdgeInsets.symmetric(vertical: 2.h),
        children: [
          _periodo(
              context, horarios[0]["periodo"], horarios[0]["horario"], tema),
          const SizedBox(height: 15),
          _periodo(
              context, horarios[1]["periodo"], horarios[1]["horario"], tema),
          const SizedBox(height: 15),
          _periodo(
              context, horarios[2]["periodo"], horarios[2]["horario"], tema),
        ],
      ),
    ),
  );
}

Widget _periodo(BuildContext context, String periodo, List<String> horas,
    ColorScheme tema) {
  return Container(
    decoration: estiloBorda(cor: tema.tertiaryContainer, radius: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            horas.length,
            (index) => Text(horas[index], style: _estilo(context)),
          ),
        ),
        Text(
          periodo,
          style: estiloTexto(16,
              cor: Theme.of(context).textTheme.bodyLarge?.color,
              peso: FontWeight.bold),
        ),
      ],
    ),
  );
}

TextStyle _estilo(BuildContext context) {
  return estiloTexto(
    16,
    cor: Theme.of(context).textTheme.bodyLarge?.color,
    peso: FontWeight.w500,
  );
}
