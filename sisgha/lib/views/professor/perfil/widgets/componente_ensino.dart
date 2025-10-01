import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../../core/utils/estilos.dart';
import '../../../../core/utils/icones.dart';
import '../../../../core/utils/padroes.dart';
import '../../../../domain/model/dados_ensino.dart';
import '../../../../viewmodels/dados_ensino_professor_provider.dart';

class WidgetEnsino extends StatefulWidget {
  const WidgetEnsino({super.key});

  @override
  State<WidgetEnsino> createState() => _WidgetEnsinoState();
}

class _WidgetEnsinoState extends State<WidgetEnsino> {
  final Duration scrollDelay = const Duration(seconds: 1);
  final CarouselSliderController turmasCarouselController =
      CarouselSliderController();

  int turmaMostrada = 0;
  int disciplinaMostrada = 0;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    return Consumer<DadosEnsinoProfessorProvider>(
      builder: (context, provider, child) {
        final listaDados = provider.dadosEnsino;

        return LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              padding:
                  EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.05),
              physics: Padroes.efeitoDeRolagem(),
              children: [
                _buildCarouselDisciplinas(listaDados, constraints, tema),
                SizedBox(height: constraints.maxHeight * 0.05),
                _buildCarouselIndicator(listaDados, constraints, tema),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCarouselDisciplinas(List<DadosEnsino> listaDados,
      BoxConstraints constraints, ColorScheme tema) {
    return CarouselSlider.builder(
      itemCount: listaDados.length,
      itemBuilder: (context, index, realIndex) {
        final isCenter = index == disciplinaMostrada;
        final opacity = isCenter ? 1.0 : 0.5;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Opacity(
            opacity: opacity,
            child: _buildDisciplinaCard(listaDados[index], constraints, tema),
          ),
        );
      },
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 0.85,
        height: constraints.maxHeight * 0.60,
        onPageChanged: (index, reason) {
          setState(() {
            disciplinaMostrada = index;
            turmaMostrada = 0;
          });
        },
      ),
    );
  }

  Widget _buildDisciplinaCard(
      DadosEnsino dado, BoxConstraints constraints, ColorScheme tema) {
    return Container(
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: tema.onSecondary, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImagem(constraints.maxWidth, constraints.maxHeight * 0.2),
          Divider(height: 0, color: tema.onTertiary, thickness: 2),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: constraints.maxHeight * 0.01),
                Text(
                  dado.disciplina.nome,
                  style:
                      estiloTexto(16, cor: tema.primary, peso: FontWeight.bold),
                ),
                SizedBox(height: constraints.maxHeight * 0.01),
                _buildInformacoesContainer(dado.cursos, constraints, tema),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagem(double width, double height) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14), topRight: Radius.circular(14)),
      child: Image.asset(
        'assets/img/gtr.jpeg',
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildInformacoesContainer(List<CursoComTurmas> cursos,
      BoxConstraints constraints, ColorScheme tema) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.02),
      height: constraints.maxHeight * 0.22,
      width: constraints.maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: tema.onSecondary, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(),
          _buildCursoSelector(cursos, tema),
          Divider(
            indent: 12.sp,
            endIndent: 12.sp,
            color: tema.onSecondary,
            thickness: 2,
          ),
          Expanded(child: _buildTurmasCarousel(cursos, tema)),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildCursoSelector(List<CursoComTurmas> cursos, ColorScheme tema) {
    return Row(
      children: [
        _buildIconButton(Icones.setaEsquerda, () {
          if (turmaMostrada > 0) turmasCarouselController.previousPage();
        }, tema),
        Expanded(
          child: TextScroll(
            cursos[turmaMostrada].curso.nome,
            style: estiloTexto(14, cor: tema.primary, peso: FontWeight.bold),
            mode: TextScrollMode.bouncing,
            velocity: const Velocity(pixelsPerSecond: Offset(10, 0)),
            delayBefore: scrollDelay,
            pauseBetween: scrollDelay,
            pauseOnBounce: scrollDelay,
          ),
        ),
        _buildIconButton(Icones.setaDireita, () {
          if (turmaMostrada < cursos[turmaMostrada].turmas.length - 1) {
            turmasCarouselController.nextPage();
          }
        }, tema),
      ],
    );
  }

  Widget _buildIconButton(
      String icon, VoidCallback onPressed, ColorScheme tema) {
    return IconButton(
      padding: EdgeInsets.zero,
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
        minimumSize: MaterialStatePropertyAll(Size(20.sp, 20.sp)),
      ),
      onPressed: onPressed,
      icon: Iconify(icon, size: 15.sp, color: tema.secondaryFixed),
    );
  }

  Widget _buildTurmasCarousel(List<CursoComTurmas> cursos, ColorScheme tema) {
    return CarouselSlider(
      disableGesture: true,
      carouselController: turmasCarouselController,
      items: cursos[turmaMostrada].turmas.map((turma) {
        return Text(
          turma.nome,
          style: estiloTexto(14, cor: tema.primary, peso: FontWeight.bold),
        );
      }).toList(),
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) => setState(() => turmaMostrada = index),
      ),
    );
  }

  Widget _buildCarouselIndicator(List<DadosEnsino> listaDados,
      BoxConstraints constraints, ColorScheme tema) {
    return Center(
      child: SizedBox(
        height: constraints.maxHeight * 0.01 + 2,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listaDados.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: constraints.maxHeight * 0.06 + 2,
              decoration: BoxDecoration(
                color: disciplinaMostrada == index
                    ? tema.onPrimary
                    : tema.onSecondary,
              ),
            );
          },
        ),
      ),
    );
  }
}
