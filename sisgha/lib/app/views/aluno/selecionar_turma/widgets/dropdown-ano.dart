import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';

class DropdownAno extends StatefulWidget {
  final String nome;
  final double direita;
  final double esquerda;
  final String descricao;

  const DropdownAno({
    super.key,
    required this.nome,
    required this.direita,
    required this.esquerda,
    required this.descricao,
  });

  @override
  State<DropdownAno> createState() => _DropdownAlunoState();
}

class _DropdownAlunoState extends State<DropdownAno> {
  String? selectedValue;
  bool isExpanded = false;
  bool isFocused = false; // Adicionado para rastrear o foco no campo

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          isFocused = true; // Quando clica, o campo fica focado
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            color: isFocused
                ? ColorsTemaClaro.verdePrincipal // Verde quando focado
                : ColorsTemaClaro.cinzaBordas, // Cinza quando não focado
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.fromLTRB(widget.esquerda, 10, widget.direita, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 42,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.descricao, // Mantém a descrição fixa
                    style: TextStyle(
                      color: isFocused
                          ? ColorsTemaClaro.pretoTexto // Preto quando focado
                          : ColorsTemaClaro.cinza, // Cinza quando não focado
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: isFocused
                        ? ColorsTemaClaro.verdePrincipal // Verde quando focado
                        : ColorsTemaClaro.cinzaBordas, // Cinza quando não focado
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? 80 : 0,
              curve: Curves.easeInOut,
              child: isExpanded
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <String>['1°Ano', '2°Ano', '3°Ano']
                            .map((option) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: ChoiceChip(
                                    label: Text(
                                      option,
                                      style: TextStyle(
                                        color: selectedValue == option
                                            ? ColorsTemaClaro.verdePrincipal // Texto verde quando selecionado
                                            : ColorsTemaClaro.cinzatexto, // Texto cinza quando não selecionado
                                      ),
                                    ),
                                    selected: selectedValue == option,
                                    showCheckmark: false, // 🔥 Remove o ícone de confere!
                                    selectedColor: selectedValue == option
                                        ? const Color.fromARGB(61, 60, 192, 82) // Fundo verde claro
                                        : Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: selectedValue == option
                                            ? ColorsTemaClaro.verdePrincipal // Borda verde
                                            : ColorsTemaClaro.cinzaBordas, // Cinza quando não selecionado
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    onSelected: (bool selected) {
                                      setState(() {
                                        selectedValue = selected ? option : null;
                                        isExpanded = true;
                                        isFocused = true;
                                      });
                                    },
                                  ),
                                ))
                            .toList(),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
