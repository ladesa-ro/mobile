import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sisgha/app/constants/colors.dart';

class WidgetEnsino extends StatefulWidget {
  const WidgetEnsino({super.key});

  @override
  State<WidgetEnsino> createState() => _WidgetEnsino();
}

class _WidgetEnsino extends State<WidgetEnsino> {
  int _paginaSelecionada = 0;
  //altera conforme a quantidade de itens
  final int _quantidadeDePaginas = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        CarouselSlider.builder(
          itemCount: _quantidadeDePaginas,
          itemBuilder: (context, index, realIdx) {
            return SizedBox(
              width: double.maxFinite,
              child: _conteudo(context, index),
            );
          },
          options: CarouselOptions(
            enableInfiniteScroll: false,
            height: 250.0,
            enlargeCenterPage: true,
            autoPlay: false,
            aspectRatio: 16 / 9,
            viewportFraction: 0.7,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _paginaSelecionada = index;
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: AlignmentDirectional.center,
          height: 15,
          width: (20 * _quantidadeDePaginas) + 12,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _quantidadeDePaginas,
            itemBuilder: (context, index) => container(index),
          ),
        )
      ],
    );
  }

  Widget container(int index) {
    return AnimatedContainer(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: index == _paginaSelecionada
            ? ColorApp.VerdeEscuro
            : ColorApp.Branco,
        border: Border.all(color: ColorApp.VerdeEscuro),
        borderRadius: BorderRadius.circular(100),
      ),
      duration: const Duration(milliseconds: 500),
      width: 15,
      height: 15,
    );
  }

  Widget _conteudo(BuildContext context, int index) {
    return LayoutBuilder(
      builder: (context, constraints) => AnimatedContainer(
        clipBehavior: Clip.antiAlias,
        height: constraints.maxHeight,
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          border: Border.all(
              color: index == _paginaSelecionada
                  ? ColorApp.VerdePrincipal
                  : ColorApp.VerdeCinza),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Image.asset(
              "assets/img/gtr.jpeg",
              fit: BoxFit.cover,
              alignment: AlignmentDirectional.bottomCenter,
              height: 60,
              width: constraints.maxWidth - 2,
            ),
          ],
        ),
      ),
    );
  }
}
