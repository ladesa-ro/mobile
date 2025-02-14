// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

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
  @override
  Widget build(BuildContext context) {
    var selectedValue;
    return SizedBox(
      height: 42,
      child: DropdownButtonFormField<String>(
        hint: Text(
          widget.descricao,
          style: TextStyle(
              color: ColorsTemaClaro.cinzatexto,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.fromLTRB(widget.esquerda, 0, widget.direita, 0),
          labelText: widget.nome,
          labelStyle: TextStyle(
              color: ColorsTemaClaro.verdecinza, fontWeight: FontWeight.w600),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsTemaClaro.verdePrincipal),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorsTemaClaro.cinzaBordas),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(),
        ),
        iconEnabledColor: ColorsTemaClaro.verdePrincipal,
        value: selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: <String>['Ensino Médio', 'Graduação', 'Pós-Graduação']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            alignment: Alignment.center,
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          );
        }).toList(),
        validator: (value) =>
            value == null ? 'Por favor, selecione uma opção' : null,
      ),
    );
  }
}
