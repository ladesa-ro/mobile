import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';

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
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: <String>['Informática', 'Química', 'Floresta']
                            .map((option) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
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
                                    selectedColor: selectedValue == option
                                        ? const Color.fromARGB(61, 60, 192, 82)
                                        : Colors.transparent,
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
                                        selectedValue =
                                            selected ? option : null;
                                        isExpanded = true;
                                        isFocused = true;
                                      });
                                      widget.onChanged(selectedValue);
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
