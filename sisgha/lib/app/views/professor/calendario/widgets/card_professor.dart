import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';

class CardsProfessor extends StatelessWidget {
  CardsProfessor({super.key});

  final List<ElementosCards> Cards = [
    ElementosCards(
      cor: CoresClaras.roxo,
      titulo: "2° etapa ",
      iconebotao: ElevatedButton(
        style: estiloBotaoCard(),
        onPressed: () {
          
        },
        child: Iconify(
          Icones.Sino,
          color: CoresClaras.branco,
        ),
      ),
      inicio: "Início: 01/04 às 08:00",
      terminio: "Término: 01/04 às 10:00",
      tempo: "Começa daqui 3 dias.",
      local: "Local: ji-parana ",
    ),
    ElementosCards(
      cor: CoresClaras.vermelho,
      titulo: "recuperação do 1° semestre ",
      iconebotao: ElevatedButton(
        style: estiloBotaoCard(),
        onPressed: () {},
        child: Iconify(
          Icones.Sino,
          color: CoresClaras.branco,
        ),
      ),
      inicio: "Início: 01/04 às 08:00",
      terminio: "Término: 01/04 às 10:00",
      tempo: "Começa daqui 3 dias.",
      local: "local: ji-parana",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double largura = Tamanhos.larguraGeral();
    return Column(
      children: Cards.map((card) => Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
              border: Border(
                left: BorderSide(
                  color: card.cor, // cor da borda
                  width: 5, // a espreçura 
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Row(
                        children: [
                          Text(
                            card.titulo,
                            style: estiloTexto(
                              16,
                              cor: card.cor,
                              peso: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                       
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        card.inicio,
                        style: estiloTexto(15),
                      ),
                      Text(
                        card.terminio,
                        style: estiloTexto(15),
                      ),
                      Text(
                        card.tempo,
                        style: estiloTexto(15),
                      ),
                      Text(
                        card.local,
                        style: estiloTexto(15),
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    height: 42,
                    width: largura * 0.11,
                    child: card.iconebotao,
                  ),
                ],
              ),
            ),
          )).toList(),
    );
  }
}

class ElementosCards {
  final Color cor;
  final String titulo;
  final ElevatedButton iconebotao;
  final String inicio;
  final String terminio;
  final String tempo;
  final String local;

  ElementosCards({
    required this.cor,
    required this.titulo,
    required this.iconebotao,
    required this.inicio,
    required this.terminio,
    required this.tempo,
    required this.local,
  });
}

ButtonStyle estiloBotaoCard() {
  return ButtonStyle(
    padding: WidgetStatePropertyAll(EdgeInsets.zero),
    backgroundColor: WidgetStatePropertyAll(CoresClaras.verdePrincipal),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
