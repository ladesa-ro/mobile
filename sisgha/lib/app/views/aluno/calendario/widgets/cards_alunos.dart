import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';

import '../../../../core/utils/padroes.dart';

class CardsAlunos extends StatelessWidget {
  CardsAlunos({super.key});

    final List<ElementosCards> Cards = [
    ElementosCards(
      cor: CoresClaras.roxo,
      titulo: "2° etapa ",
      iconebotao: ElevatedButton(
        style: estiloBotaoCard(),
        onPressed: () {},
        child: Iconify(
          Icones.sino,
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
      titulo: "Recuperação do 1° semestre ",
      iconebotao: ElevatedButton(
        style: estiloBotaoCard(),
        onPressed: () {},
        child: Iconify(
          Icones.sino,
          color: CoresClaras.branco,
        ),
      ),
      inicio: "Início: 01/04 às 08:00",
      terminio: "Término: 01/04 às 10:00",
      tempo: "Começa daqui 3 dias.",
      local: "local: ji-parana",
    ),
    ElementosCards(
      cor: CoresClaras.roxo,
      titulo: "2° etapa ",
      iconebotao: ElevatedButton(
        style: estiloBotaoCard(),
        onPressed: () {},
        child: Iconify(
          Icones.sino,
          color: CoresClaras.branco,
        ),
      ),
      inicio: "Início: 01/04 às 08:00",
      terminio: "Término: 01/04 às 10:00",
      tempo: "Começa daqui 3 dias.",
      local: "Local: ji-parana "),
    ElementosCards(
      cor: CoresClaras.vermelho,
      titulo: "Recuperação do 1° semestre ",
      iconebotao: ElevatedButton(
        style: estiloBotaoCard(),
        onPressed: () {},
        child: Iconify(
          Icones.sino,
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
    double largura = Padroes.larguraGeral();

    return ListView.builder(
      cacheExtent: 500,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: Cards.length,
      itemBuilder: (ctx, index) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 8,
          ),
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
                color: Cards[index].cor, // cor da borda
                width: 5, // a espreçura
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Cards[index].titulo,
                        style: estiloTexto(
                          16,
                          cor: Cards[index].cor,
                          peso: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(Cards[index].inicio, style: estiloTexto(16)),
                      Text(Cards[index].terminio, style: estiloTexto(16)),
                      Text(Cards[index].tempo, style: estiloTexto(16)),
                      Text(Cards[index].local, style: estiloTexto(16)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  height: 45,
                  width: largura * 0.115,
                  child: Cards[index].iconebotao,
                ),
              ),
            ],
          ),
        );
      },
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