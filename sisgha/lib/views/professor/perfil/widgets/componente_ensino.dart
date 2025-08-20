import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/core/utils/icones.dart';
import 'package:sisgha/domain/model/dados_ensino.dart';
import 'package:sisgha/viewmodels/dados_ensino_professor_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/estilos.dart';
import '../../../../core/utils/padroes.dart';

class WidgetEnsino extends StatefulWidget {
  const WidgetEnsino({super.key});

  @override
  State<WidgetEnsino> createState() => _WidgetEnsino();
}

class _WidgetEnsino extends State<WidgetEnsino> {
  final duracao = Duration(seconds: 1);
  CarouselSliderController turmasCarouselController =
      CarouselSliderController();
  int turmaMostrada = 0;

  int diciplinaMostrada = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<DadosEnsinoProfessorProvider>(
        builder: (context, provider, child) {
      final listaDados = provider.dadosEnsino;

      return LayoutBuilder(
          builder: (constext, constraints) => ListView(
                physics: Padroes.efeitoDeRolagem(),
                children: [
                  CarouselSlider(
                    items: listaDados.map((dado) {
                      return Builder(builder: (context) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: CoresClaras.cinzaBordas, width: 2)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mostrarImagem(constraints.maxWidth,
                                  constraints.maxHeight * 0.2),
                              Divider(
                                height: 0,
                                color: CoresClaras.cinzaBordas,
                                thickness: 2,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: constraints.maxWidth * 0.04),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              constraints.maxHeight * 0.01),
                                      child: Text(
                                        dado.disciplina.nome,
                                        style: estiloTexto(16,
                                            cor: CoresClaras.pretoTexto,
                                            peso: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              constraints.maxWidth * 0.02),
                                      height: constraints.maxHeight * 0.22,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: CoresClaras.cinzaBordas,
                                            width: 2),
                                      ),
                                      child: mostrarInformacoes(dado.cursos),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      });
                    }).toList(),
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                      height: constraints.maxHeight * 0.60,
                      onPageChanged: (index, reason) => setState(() {
                        diciplinaMostrada = index;
                      }),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  Center(
                    child: SizedBox(
                      height: constraints.maxHeight * 0.01 + 2,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listaDados.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: constraints.maxHeight * 0.06 + 2,
                            decoration: BoxDecoration(
                              color: diciplinaMostrada == index
                                  ? CoresClaras.preto
                                  : CoresClaras.cinzaBordas,
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ));
    });
  }

  Widget mostrarImagem(double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(14), topRight: Radius.circular(14)),
      child: Image.asset(
        'assets/img/gtr.jpeg',
        height: height,
        width: width,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget mostrarInformacoes(List<CursoComTurmas> dados) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            IconButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  minimumSize: WidgetStatePropertyAll(Size(15.sp, 15.sp)),
                ),
                onPressed: () {
                  if (turmaMostrada > 0) {
                    setState(() {
                      turmasCarouselController.previousPage();
                    });
                  }
                },
                icon: Iconify(
                  Icones.setaEsquerda,
                  size: 15.sp,
                  color: CoresClaras.verdePrincipal,
                )),
            Expanded(
              child: TextScroll(
                dados[turmaMostrada].curso.nome,
                style: estiloTexto(14,
                    cor: CoresClaras.pretoTexto, peso: FontWeight.bold),
                mode: TextScrollMode.bouncing,
                velocity: Velocity(pixelsPerSecond: Offset(10, 0)),
                delayBefore: duracao,
                pauseBetween: duracao,
                pauseOnBounce: duracao,
              ),
            ),
            IconButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  minimumSize: WidgetStatePropertyAll(Size(15.sp, 15.sp)),
                ),
                onPressed: () {
                  if (turmaMostrada < dados[turmaMostrada].turmas.length - 1) {
                    setState(() {
                      turmasCarouselController.nextPage();
                    });
                  }
                },
                icon: Iconify(
                  Icones.setaDireita,
                  size: 15.sp,
                  color: CoresClaras.verdePrincipal,
                )),
          ],
        ),
        Divider(
          height: 20,
          color: CoresClaras.cinzaBordas,
          thickness: 2,
        ),
        Expanded(
          child: CarouselSlider(
              carouselController: turmasCarouselController,
              items: dados[turmaMostrada].turmas.map((turma) {
                return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      turma.nome,
                      style: estiloTexto(14,
                          cor: CoresClaras.pretoTexto, peso: FontWeight.bold),
                    ));
              }).toList(),
              options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index, reason) =>
                    atualizarIndexDaturmaMostrada(index),
              )),
        ),
      ],
    );
  }

  void atualizarIndexDaturmaMostrada(index) {
    setState(() {
      turmaMostrada = index;
    });
  }
}
