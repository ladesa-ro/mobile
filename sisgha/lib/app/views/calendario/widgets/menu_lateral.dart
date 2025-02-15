import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';
import 'package:sisgha/app/data/api/repository.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/Icones.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/estilos.dart';
import '../../../core/utils/responsividade.dart';
import '../../../data/providers/escolha_menu_lateral.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({super.key});

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Drawer build(BuildContext context) {
    return Drawer(
      width: TamanhoTela.horizontal(context) * 0.82,
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
              Divider(thickness: 2),
              //ano
              SizedBox(height: constraints.maxHeight * 0.03),
              Text(
                'Ano Letivo',
                style: estiloTexto(16,
                    cor: ColorsTemaClaro.verdePrincipalTexto,
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
                    cor: ColorsTemaClaro.verdePrincipalTexto,
                    peso: FontWeight.bold),
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              quadradosModalidade(context, constraints.maxHeight * 0.05),
              //calendario
              SizedBox(height: constraints.maxHeight * 0.03),
              Text(
                'Calendário',
                style: estiloTexto(16,
                    cor: ColorsTemaClaro.verdePrincipalTexto,
                    peso: FontWeight.bold),
              ),
              SizedBox(height: constraints.maxHeight * 0.02),
              quadradoCurso(context, constraints.maxHeight * 0.05),

              //botao
              Spacer(),
              SizedBox(
                height: constraints.maxHeight * 0.07,
                child: ElevatedButton(
                    style: Tamanhos.estiloBotao(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        'Buscar',
                        style: estiloTexto(15,
                            cor: ColorsTemaClaro.brancoTexto,
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
                  cor: ColorsTemaClaro.verdePrincipal, peso: FontWeight.bold),
            ),
            Text(
              'Selecione as informações',
              style: estiloTexto(15,
                  cor: ColorsTemaClaro.cinzaEscuro, peso: FontWeight.bold),
            ),
          ],
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            //Navigator.pop(context);
            buscarCursos();
          },
          icon: Iconify(
            Icones.setaVoltarEsquerda,
            color: ColorsTemaClaro.verdePrincipal,
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
                  ? ColorsTemaClaro.verdePrincipalTexto
                  : ColorsTemaClaro.verdecinzaTexto,
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
                    ? ColorsTemaClaro.verdePrincipalTexto
                    : ColorsTemaClaro.verdecinzaTexto,
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
                    ? ColorsTemaClaro.verdePrincipalTexto
                    : ColorsTemaClaro.verdecinzaTexto,
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
        ? ColorsTemaClaro.verdeTransparente
        : ColorsTemaClaro.pretoTransparente,
    border: Border.all(
      width: 1.5,
      color: indexAtual == indexSelecionado
          ? ColorsTemaClaro.verdePrincipalBorda
          : Colors.transparent,
    ),
    borderRadius: BorderRadius.circular(12),
  );
}
