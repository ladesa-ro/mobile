import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/responsividade.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';
import 'package:sisgha/app/data/providers/escolha_horarios_alunos.dart';

class DropdownCurso extends StatefulWidget {
  final double direita;
  final double esquerda;
  final String descricao;
  final Function(String?) onChanged;
  final bool abrirDropdown;

  const DropdownCurso({
    super.key,
    required this.direita,
    required this.esquerda,
    required this.descricao,
    required this.onChanged,
    this.abrirDropdown = false,
  });

  @override
  State<DropdownCurso> createState() => _DropdownAlunoState();
}

class _DropdownAlunoState extends State<DropdownCurso> {
  String? selectedValue;
  bool isExpanded = false;
  bool isFocused = false;

  @override
  void didUpdateWidget(covariant DropdownCurso oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.abrirDropdown != oldWidget.abrirDropdown) {
      setState(() {
        isExpanded = widget.abrirDropdown;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.abrirDropdown) {
      isExpanded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var listaCursos = Provider.of<EscolhaHorariosAlunos>(context).listaCursos;
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
          isFocused = true;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: TamanhoTela.horizontal(context) * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedValue != null
                ? CoresClaras.verdePrincipal
                : CoresClaras.cinzaBordas,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.fromLTRB(
          TamanhoTela.horizontal(context) * 0.03,
          TamanhoTela.vertical(context) * 0.01,
          TamanhoTela.horizontal(context) * 0.03,
          TamanhoTela.vertical(context) * 0.01,
        ),
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
                          ? CoresClaras.pretoTexto
                          : CoresClaras.cinza,
                      fontSize: TamanhoTela.horizontal(context) * 0.03,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: selectedValue != null
                        ? CoresClaras.verdePrincipal
                        : CoresClaras.cinzaBordas,
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? TamanhoTela.vertical(context) * 0.1 : 0,
              curve: Curves.easeInOut,
              child: isExpanded
                  ? ListView.builder(
                      physics: Tamanhos.efeitoDeRolagem(),
                      scrollDirection: Axis.horizontal,
                      itemCount: listaCursos.length,
                      itemBuilder: (context, index) =>
                          construirQuadrados(listaCursos[index].nome),
                    )
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
            fontSize: TamanhoTela.horizontal(context) * 0.03,
            color: selectedValue == option
                ? CoresClaras.verdePrincipal
                : CoresClaras.cinzatexto,
          ),
        ),
        selected: selectedValue == option,
        showCheckmark: false,
        selectedColor: selectedValue == option
            ? const Color.fromARGB(61, 60, 192, 82)
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: selectedValue == option
                ? CoresClaras.verdePrincipal
                : CoresClaras.cinzaBordas,
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
