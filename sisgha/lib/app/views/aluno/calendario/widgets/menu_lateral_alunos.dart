import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/padroes.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/icones.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/estilos.dart';

import '../../../../cache/escolha_calendario.dart';

class MenuLateralAlunos extends StatefulWidget {
  const MenuLateralAlunos({super.key});

  @override
  State<MenuLateralAlunos> createState() => _MenuLateralAlunosState();
}

class _MenuLateralAlunosState extends State<MenuLateralAlunos> {
  @override
  Drawer build(BuildContext context) {
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
                  context, constraints.maxHeight, constraints.maxWidth),
              Divider(
                thickness: 2,
                color: CoresClaras.verdecinza,
              ),
              //ano
              SizedBox(height: constraints.maxHeight * 0.03),
              Text(
                'Ano Letivo',
                style: estiloTexto(16,
                    cor: CoresClaras.verdePrincipalTexto,
                    peso: FontWeight.bold),
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              SizedBox(
                height: constraints.maxHeight * 0.05,
                width: constraints.maxWidth,
                child: quadradosAnos(context),
              ),
              //modalidade
              SizedBox(height: constraints.maxHeight * 0.03),
              Text(
                'Modalidade',
                style: estiloTexto(16,
                    cor: CoresClaras.verdePrincipalTexto,
                    peso: FontWeight.bold),
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              quadradosModalidade(context, constraints.maxHeight * 0.05),
              //calendario
              SizedBox(height: constraints.maxHeight * 0.03),
              Text(
                'Calendário',
                style: estiloTexto(16,
                    cor: CoresClaras.verdePrincipalTexto,
                    peso: FontWeight.bold),
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              quadradoCurso(context, constraints.maxHeight * 0.05),

              //botao
              Spacer(),
              SizedBox(
                height: constraints.maxHeight * 0.07,
                child: ElevatedButton(
                    style: Padroes.estiloBotao(context),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Buscar',
                        style: estiloTexto(15,
                            cor: CoresClaras.brancoTexto,
                            peso: FontWeight.bold),
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

Widget headerDrawer(BuildContext context, double height, double width) {
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
              style: estiloTexto(16,
                  cor: CoresClaras.verdePrincipal, peso: FontWeight.bold),
            ),
            Text(
              'Selecione as informações',
              style: estiloTexto(15,
                  cor: CoresClaras.cinzaEscuro, peso: FontWeight.bold),
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
            color: CoresClaras.verdePrincipal,
            size: 5.h,
          ),
        )
      ],
    ),
  );
}

Widget quadradosAnos(BuildContext context) {
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
        decoration: _decoration(index, provider.anoSelecionado),
        child: Text(
          listaAnos[index],
          style: estiloTexto(15,
              cor: index == provider.anoSelecionado
                  ? CoresClaras.verdePrincipalTexto
                  : CoresClaras.verdecinzaTexto,
              peso: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget quadradosModalidade(BuildContext context, double height) {
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
          decoration: _decoration(index, provider.cursoSelecionado),
          child: Text(
            listaModalidade[index],
            style: estiloTexto(15,
                cor: index == provider.cursoSelecionado
                    ? CoresClaras.verdePrincipalTexto
                    : CoresClaras.verdecinzaTexto,
                peso: FontWeight.bold),
          ),
        ),
      );
    }).toList(),
  );
}

Widget quadradoCurso(BuildContext context, double height) {
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
          decoration: _decoration(index, provider.modalidadeSelecionada),
          child: Text(
            listaCurso[index],
            style: estiloTexto(15,
                cor: index == provider.modalidadeSelecionada
                    ? CoresClaras.verdePrincipalTexto
                    : CoresClaras.verdecinzaTexto,
                peso: FontWeight.bold),
          ),
        ),
      );
    }).toList(),
  );
}

BoxDecoration _decoration(int indexAtual, int indexSelecionado) {
  return BoxDecoration(
    color: indexAtual == indexSelecionado
        ? CoresClaras.verdeTransparente
        : CoresClaras.pretoTransparente,
    border: Border.all(
      width: 1.5,
      color: indexAtual == indexSelecionado
          ? CoresClaras.verdePrincipalBorda
          : Colors.transparent,
    ),
    borderRadius: BorderRadius.circular(12),
  );
}
