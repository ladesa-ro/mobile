import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widget_sair.dart';

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
          height: 25,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
              width: (20 * _quantidadeDePaginas) + 12,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _quantidadeDePaginas,
                itemBuilder: (context, index) => contagemDePagina(index),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widgetQuit(context),
          ],
        ),
      ],
    );
  }

  Widget contagemDePagina(int index) {
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/img/gtr.jpeg",
              fit: BoxFit.cover,
              alignment: AlignmentDirectional.bottomCenter,
              height: 70,
              width: constraints.maxWidth - 2,
            ),
            const Divider(
              height: 1,
              color: ColorApp.VerdeCinza,
              thickness: 2,
            ),
            Container(
              width: constraints.maxWidth,
              padding: const EdgeInsetsDirectional.only(start: 20, top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Técnico em Informatica',
                    style: estiloTexto(16,
                        cor: ColorApp.Preto, peso: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Turmas: 1A 2B 3C',
                    style: estiloTexto(16,
                        cor: ColorApp.VerdeCinza, peso: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 40,
              width: constraints.maxWidth,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, idex) => Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20),
                  width: constraints.maxWidth * 0.30,
                  height: 10,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: index == _paginaSelecionada
                              ? ColorApp.Preto
                              : ColorApp.VerdeCinza,
                          width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'testando',
                    style: estiloTexto(16,
                        cor: ColorApp.Preto, peso: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
