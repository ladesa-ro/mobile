import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';

class WidgetDisponibilidade extends StatefulWidget {
  const WidgetDisponibilidade({super.key});

  @override
  State<WidgetDisponibilidade> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WidgetDisponibilidade> {
  List<String> dias = ['Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta'];
  int diaIndex = 0;

  final CarouselSliderController _carouselSliderController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: ColorApp.VerdePrincipal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _iconButton(1, Icones.setaEsquerda),
                const Spacer(),
                Text(
                  dias[diaIndex],
                  style: estiloTexto(17,
                      cor: ColorApp.Branco, peso: FontWeight.bold),
                ),
                const Spacer(),
                _iconButton(0, Icones.setaDireita),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Flexible(
            child: CarouselSlider(
              carouselController: _carouselSliderController,
              items: _listaComHorarios(context),
              options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                height: constraints.maxHeight,
                scrollPhysics: const NeverScrollableScrollPhysics(),
              ),
            ),
          )
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

  IconButton _iconButton(int index, String icone) {
    return IconButton(
      onPressed: () {
        _alternarEntreDias(index);
      },
      icon: Iconify(icone, color: ColorApp.Branco),
    );
  }
}

List<Widget> _listaComHorarios(context) {
  return [
    //seg
    Column(
      children: [
        _matutino(context),
        const SizedBox(height: 15),
        _vespertino(context),
        const SizedBox(height: 15),
        _noturno(context),
      ],
    ),
    //ter
    Column(
      children: [
        _matutino(context),
        const SizedBox(height: 15),
        _vespertino(context),
        const SizedBox(height: 15),
        _noturno(context),
      ],
    ),
    //qua
    Column(
      children: [
        _matutino(context),
        const SizedBox(height: 15),
        _vespertino(context),
        const SizedBox(height: 15),
        _noturno(context),
      ],
    ),
    //qui
    Column(
      children: [
        _matutino(context),
        const SizedBox(height: 15),
        _vespertino(context),
        const SizedBox(height: 15),
        _noturno(context),
      ],
    ),
    //sex
    Column(
      children: [
        _matutino(context),
        const SizedBox(height: 15),
        _vespertino(context),
        const SizedBox(height: 15),
        _noturno(context),
      ],
    ),
  ];
}

Widget _matutino(context) {
  return Container(
    height: 175,
    width: double.infinity,
    decoration: boxDecoration(),
    child: _horariosMatutino(),
  );
}

Widget _vespertino(context) {
  return Container(
    height: 175,
    width: double.infinity,
    decoration: boxDecoration(),
    child: _horariosVespertino(),
  );
}

Widget _noturno(context) {
  return Container(
    height: 175,
    width: double.infinity,
    decoration: boxDecoration(),
    child: _horariosNoturno(),
  );
}

Widget _horariosMatutino() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
        ],
      ),
      Text('Matutino',
          style: estiloTexto(16, cor: ColorApp.Preto, peso: FontWeight.bold)),
    ],
  );
}

Widget _horariosVespertino() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
        ],
      ),
      Text('Vespertino',
          style: estiloTexto(16, cor: ColorApp.Preto, peso: FontWeight.bold)),
    ],
  );
}

Widget _horariosNoturno() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
          Text('00:00 - 00:00', style: _estilo()),
        ],
      ),
      Text('Noturno',
          style: estiloTexto(16, cor: ColorApp.Preto, peso: FontWeight.bold)),
    ],
  );
}

TextStyle _estilo() {
  return estiloTexto(16, cor: ColorApp.Preto, peso: FontWeight.w500);
}
