import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/domain/model/dados_ensino.dart';
import 'package:sisgha/viewmodels/dados_ensino_professor_provider.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/estilos.dart';
import '../../../../core/utils/padroes.dart';

class WidgetEnsino extends StatefulWidget {
  const WidgetEnsino({super.key});

  @override
  State<WidgetEnsino> createState() => _WidgetEnsino();
}

class _WidgetEnsino extends State<WidgetEnsino> {
  int cursoIndex = 0;
  CarouselSliderController turmasCarouselController =
      CarouselSliderController();

  int paginaMostrada = 0;
  void _atualizarIndexDaPaginaMostrada(index) {
    setState(() {
      paginaMostrada = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (constext, constraints) => ListView(
        physics: Padroes.efeitoDeRolagem(),
        children: [
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Consumer<DadosEnsinoProfessorProvider>(
              builder: (context, provider, child) {
            final listaDados = provider.dadosEnsino;

            return CarouselSlider(
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
                        mostrarImagem(
                            constraints.maxWidth, constraints.maxHeight * 0.15),
                        Divider(
                          height: 0,
                          color: CoresClaras.cinzaBordas,
                          thickness: 2,
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dado.disciplina.nome,
                                style: estiloTexto(16,
                                    cor: CoresClaras.pretoTexto,
                                    peso: FontWeight.bold),
                              ),
                              Container(
                                height: constraints.maxHeight * 0.2,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      color: CoresClaras.cinzaBordas, width: 2),
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
                onPageChanged: (index, reason) =>
                    _atualizarIndexDaPaginaMostrada(index),
                enableInfiniteScroll: false,
                viewportFraction: 1,
                enlargeCenterPage: false,
                height: constraints.maxHeight * 0.50,
              ),
            );
          }),
          SizedBox(height: 15),
        ],
      ),
    );
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
      children: [
        Row(
          children: [Text(dados[cursoIndex].curso.nome)],
        ),
        Divider(),
        CarouselSlider(
            carouselController: turmasCarouselController,
            items: dados[cursoIndex].turmas.map((turma) {
              return Text(turma.nome);
            }).toList(),
            options: CarouselOptions(
              enableInfiniteScroll: false,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              height: 10,
              scrollPhysics: const NeverScrollableScrollPhysics(),
            ))
      ],
    );
  }
}
