import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';

class DropdownFormacao extends StatefulWidget {
  final String nome;
  final double direita;
  final double esquerda;
  final String descricao;
  const DropdownFormacao({
    super.key,
    required this.nome,
    required this.direita,
    required this.esquerda,
    required this.descricao,
  });

  @override
  State<DropdownFormacao> createState() => _DropdownAlunoState();
}

class _DropdownAlunoState extends State<DropdownFormacao> {
  var selectedValue;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedValue != null
                ? ColorsTemaClaro.verdePrincipal  // Verde se tiver algo selecionado
                : ColorsTemaClaro.cinzaBordas,    // Cinza se não tiver nada
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.fromLTRB(widget.esquerda, 0, widget.direita, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 42,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedValue ?? widget.descricao,
                    style: TextStyle(
                      color: ColorsTemaClaro.cinzatexto,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: ColorsTemaClaro.verdePrincipal,
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: isExpanded ? 80 : 0,  // Expande um pouco mais para baixo
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <String>['Técnico', 'Graduação', 'Concomitante']
                      .map((option) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ChoiceChip(
                              label: Text(option),
                              labelStyle: TextStyle(
                                color: selectedValue == option
                                    ? Colors.white
                                    : ColorsTemaClaro.cinzatexto,
                              ),
                              selected: selectedValue == option,
                              selectedColor: ColorsTemaClaro.verdePrincipal,
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedValue = selected ? option : null;
                                  isExpanded = false;
                                });
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
