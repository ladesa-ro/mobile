import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/utils/icones.dart';
import '../../../../core/utils/cores.dart';
import '../../../../core/utils/estilos.dart';
import '../../../../core/utils/padroes.dart';
import '../../../../viewmodels/escolha_calendario.dart';

class MenuLateralAlunos extends StatefulWidget {
  const MenuLateralAlunos({super.key});

  @override
  State<MenuLateralAlunos> createState() => _MenuLateralAlunosState();
}

class _MenuLateralAlunosState extends State<MenuLateralAlunos> {
  @override
  Drawer build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    return Drawer(
      width: Padroes.larguraGeral() * 0.82,
      child: LayoutBuilder(
        builder: (context, constraints) => Container(
          margin: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.03),
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: constraints.maxHeight * 0.03),
              headerDrawer(
                  context, constraints.maxHeight, constraints.maxWidth, tema),
              Divider(
                thickness: 2,
                color: tema.tertiary,
              ),
              //ano
              SizedBox(height: constraints.maxHeight * 0.03),
              Text(
                'Ano Letivo',
                style:
                    estiloTexto(16, cor: tema.onPrimary, peso: FontWeight.bold),
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              SizedBox(
                height: constraints.maxHeight * 0.05,
                width: constraints.maxWidth,
                child: quadradosAnos(context, tema),
              ),
              //modalidade
              SizedBox(height: constraints.maxHeight * 0.03),
              Text(
                'Modalidade',
                style:
                    estiloTexto(16, cor: tema.onPrimary, peso: FontWeight.bold),
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              quadradosModalidade(context, constraints.maxHeight * 0.05, tema),
              //calendario
              SizedBox(height: constraints.maxHeight * 0.03),
              Text(
                'Calendário',
                style:
                    estiloTexto(16, cor: tema.onPrimary, peso: FontWeight.bold),
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              quadradoCurso(context, constraints.maxHeight * 0.05, tema),

              //botao
              Spacer(),
              SizedBox(
                height: constraints.maxHeight * 0.07,
                child: ElevatedButton(
                    style: Padroes.estiloBotao(context, tema),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Buscar',
                        style: estiloTexto(15,
                            cor: tema.primaryFixed, peso: FontWeight.bold),
                      ),
                    )),
              ),
              SizedBox(height: constraints.maxHeight * 0.02)
            ],
          ),
        ),
      ),
    );
  }
}

Widget headerDrawer(
    BuildContext context, double height, double width, ColorScheme tema) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    height: height * 0.1,
    width: width,
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Calendário Parcial',
              style:
                  estiloTexto(16, cor: tema.onPrimary, peso: FontWeight.bold),
            ),
            Text(
              'Selecione as informações',
              style: estiloTexto(15, cor: tema.tertiary, peso: FontWeight.bold),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Iconify(
            Icones.setaVoltarEsquerda,
            color: tema.onSurfaceVariant,
            size: 5.h,
          ),
        )
      ],
    ),
  );
}

Widget quadradosAnos(BuildContext context, ColorScheme tema) {
  final provider = Provider.of<EscolhaCalendario>(context);
  final listaAnos = provider.anos;

  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: listaAnos.length,
    itemBuilder: (context, index) => GestureDetector(
      onTap: () => provider.alterarAnoSelecionado(index),
      child: AnimatedContainer(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        margin: EdgeInsets.only(right: 20),
        duration: Duration(milliseconds: 300),
        decoration: _decoration(index, provider.anoSelecionado, tema),
        child: Text(
          listaAnos[index],
          style: estiloTexto(15,
              cor: index == provider.anoSelecionado
                  ? tema.tertiary
                  : tema.tertiary,
              peso: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget quadradosModalidade(
    BuildContext context, double height, ColorScheme tema) {
  final provider = Provider.of<EscolhaCalendario>(context);
  final listaModalidade = provider.modalidades;
  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: listaModalidade.asMap().entries.map((entry) {
      int index = entry.key;

      return GestureDetector(
        onTap: () => provider.alterarCursoSelecionado(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: _decoration(index, provider.cursoSelecionado, tema),
          child: Text(
            listaModalidade[index],
            style: estiloTexto(15,
                cor: index == provider.cursoSelecionado
                    ? tema.tertiary
                    : tema.tertiary,
                peso: FontWeight.bold),
          ),
        ),
      );
    }).toList(),
  );
}

Widget quadradoCurso(BuildContext context, double height, ColorScheme tema) {
  final provider = Provider.of<EscolhaCalendario>(context);
  final listaCurso = provider.cursos;

  return Wrap(
    spacing: 10,
    runSpacing: 10,
    children: listaCurso.asMap().entries.map((entry) {
      int index = entry.key;

      return GestureDetector(
        onTap: () => provider.alterarModalidadeSelecionada(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: _decoration(index, provider.modalidadeSelecionada, tema),
          child: Text(
            listaCurso[index],
            style: estiloTexto(15,
                cor: index == provider.modalidadeSelecionada
                    ? tema.tertiary
                    : tema.tertiary,
                peso: FontWeight.bold),
          ),
        ),
      );
    }).toList(),
  );
}

BoxDecoration _decoration(
    int indexAtual, int indexSelecionado, ColorScheme tema) {
  return BoxDecoration(
    color: indexAtual == indexSelecionado
        ? Colors.transparent
        : Colors.transparent,
    border: Border.all(
      width: 1.5,
      color: indexAtual == indexSelecionado
          ? tema.tertiaryContainer
          : tema.tertiaryContainer,
    ),
    borderRadius: BorderRadius.circular(12),
  );
}
