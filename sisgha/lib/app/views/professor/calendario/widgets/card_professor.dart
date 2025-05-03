import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/core/utils/icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/padroes.dart';

class CardsProfessor extends StatelessWidget {
  CardsProfessor({super.key});

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
      titulo: "recuperação do 1° semestre ",
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

    return SizedBox(
      height: 400, // Defina altura máxima visível (ajustável)
      child: ListView.builder(
        physics: Padroes.efeitoDeRolagem(),
        itemCount: Cards.length,
        itemBuilder: (context, index) {
          final card = Cards[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border(
                left: BorderSide(
                  color: card.cor,
                  width: 5,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.titulo,
                          style: estiloTexto(
                            16,
                            cor: card.cor,
                            peso: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(card.inicio, style: estiloTexto(15)),
                        Text(card.terminio, style: estiloTexto(15)),
                        Text(card.tempo, style: estiloTexto(15)),
                        Text(card.local, style: estiloTexto(15)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 42,
                    width: largura * 0.11,
                    child: card.iconebotao,
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
