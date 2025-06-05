import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/padroes.dart';

class WidgetEnsino extends StatefulWidget {
  const WidgetEnsino({super.key});

  @override
  State<WidgetEnsino> createState() => _WidgetEnsino();
}

class _WidgetEnsino extends State<WidgetEnsino> {
  final List<Map<String, dynamic>> materias = [
    {
      "materia": "Matemática",
      "cursos": [
        {
          "curso": "Informática",
          "anos": ["1ºA", "1ºB", "2ºA", "3ºA"],
        },
        {
          "curso": "Quimica",
          "anos": ["1ºA", "2ºA", "3ºA"],
        },
        {
          "curso": "Floresta",
          "anos": ["1ºA", "2ºA", "3ºA"],
        }
      ]
    },
    {
      "materia": "Português",
      "cursos": [
        {
          "curso": "Informática",
          "anos": ["1ºA", "1ºB", "2ºA", "3ºA"],
        },
        {
          "curso": "Quimica",
          "anos": ["1ºA", "2ºA", "3ºA"],
        },
      ]
    },
    {
      "materia": "Geografia",
      "cursos": [
        {
          "curso": "Informática",
          "anos": ["1ºA", "1ºB", "2ºA", "3ºA"],
        },
      ]
    },
  ];
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
          CarouselSlider(
            items: List.generate(materias.length,
                (index) => gerador(constraints.maxWidth, index)),
            options: CarouselOptions(
              onPageChanged: (index, reason) =>
                  _atualizarIndexDaPaginaMostrada(index),
              enableInfiniteScroll: false,
              viewportFraction: 0.8,
              enlargeCenterPage: false,
              height: constraints.maxHeight * 0.50,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              materias.length,
              (index) => _animatedContainer(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget gerador(double largura, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      decoration: estiloBorda(cor: CoresClaras.verdecinzaBorda, radius: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9),
              topRight: Radius.circular(9),
            ),
            child: Image.asset(
              'assets/img/gtr.jpeg',
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              width: largura,
              height: 70,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    materias[index]["materia"],
                    style: estiloTexto(14, peso: FontWeight.bold),
                  ),
                ),
                _mostrarInformacoesdaMateria(index),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mostrarInformacoesdaMateria(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: materias[index]["cursos"].map<Widget>((curso) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: CoresClaras.verdecinza),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Text(
                  curso["curso"],
                  style: estiloTexto(14, peso: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  curso["anos"].join(", "),
                  style: estiloTexto(14, peso: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  AnimatedContainer _animatedContainer(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(
          color: paginaMostrada == index
              ? CoresClaras.verdePrincipalBorda
              : CoresClaras.verdecinzaBorda,
        ),
        borderRadius: BorderRadius.circular(100),
        color: paginaMostrada == index
            ? CoresClaras.verdePrincipal
            : CoresClaras.branco,
      ),
      width: 15,
      height: 15,
    );
  }
}
