import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';
import 'package:sisgha/app/data/providers/escolha_horarios_alunos.dart';

class DropdownFormacao extends StatefulWidget {
  final double direita;
  final double esquerda;
  final String descricao;
  final Function(String?) onChanged;

  const DropdownFormacao({
    super.key,
    required this.direita,
    required this.esquerda,
    required this.descricao,
    required this.onChanged,
  });

  @override
  State<DropdownFormacao> createState() => _DropdownFormacaoState();
}

class _DropdownFormacaoState extends State<DropdownFormacao> {
  String? selectedValue;
  bool isExpanded = true;
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EscolhaHorariosAlunos>(context);
    var listaFormacoes = provider.listaNivelFormacao;
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          isFocused = true;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedValue != null
                ? ColorsTemaClaro.verdePrincipal
                : ColorsTemaClaro.cinzaBordas,
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
                    widget.descricao,
                    style: TextStyle(
                      color: selectedValue != null
                          ? ColorsTemaClaro.pretoTexto
                          : ColorsTemaClaro.cinza,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: selectedValue != null
                        ? ColorsTemaClaro.verdePrincipal
                        : ColorsTemaClaro.cinzaBordas,
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? 80 : 0,
              curve: Curves.easeInOut,
              child: isExpanded
                  ? ListView.builder(
                      physics: Tamanhos.efeitoDeRolagem(),
                      scrollDirection: Axis.horizontal,
                      itemCount: listaFormacoes.length,
                      itemBuilder: (context, index) =>
                          construirQuadrados(listaFormacoes[index].slug))
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget construirQuadrados(option) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(
          option,
          style: TextStyle(
            color: selectedValue == option
                ? ColorsTemaClaro.verdePrincipal
                : ColorsTemaClaro.cinzatexto,
          ),
        ),
        selected: selectedValue == option,
        showCheckmark: false,
        selectedColor: const Color.fromARGB(61, 60, 192, 82),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: selectedValue == option
                ? ColorsTemaClaro.verdePrincipal
                : ColorsTemaClaro.cinzaBordas,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        onSelected: (bool selected) {
          setState(() {
            selectedValue = selected ? option : null;
            isExpanded = true;
            isFocused = true;
          });
          widget.onChanged(selectedValue);
        },
      ),
    );
  }
}
