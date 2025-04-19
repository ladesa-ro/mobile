import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/Icones.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/core/utils/responsividade.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';
import 'package:sisgha/app/providers/escolha_horarios_alunos.dart';

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
              height: 36,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.descricao,
                    style: TextStyle(
                      color: selectedValue != null
                          ? CoresClaras.pretoTexto
                          : CoresClaras.cinza,
                      fontSize: TamanhoTela.horizontal(context) * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Transform.rotate(
                    angle: isExpanded
                        ? 3.14
                        : 0, // gira 180° pq n achei o msm icon com seta pra cima ai a solução mais simples foi girar o  icon
                    child: Iconify(
                      Icones.SetaBaixo,
                      color: selectedValue != null
                          ? CoresClaras.verdePrincipal
                          : CoresClaras.cinzaBordas,
                      size: 36,
                    ),
                  ),

                  /*
                  Icon(
                    isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: selectedValue != null
                        ? CoresClaras.verdePrincipal
                        : CoresClaras.cinzaBordas,
                        size: 36,
                  ),
                  */
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isExpanded ? TamanhoTela.vertical(context) * 0.06 : 0,
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
            fontSize: TamanhoTela.horizontal(context) * 0.03,
            color: selectedValue == option
                ? CoresClaras.verdePrincipal
                : CoresClaras.cinzatexto,
          ),
        ),
        selected: selectedValue == option,
        showCheckmark: false,
        selectedColor: const Color.fromARGB(61, 60, 192, 82),
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
