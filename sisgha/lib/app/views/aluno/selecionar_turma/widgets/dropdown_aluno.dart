// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';

class DropdownAluno extends StatefulWidget {
  final String nome;
  final double direita;
  final double esquerda;
  final String descricao;
  const DropdownAluno({
    super.key,
    required this.nome,
    required this.direita,
    required this.esquerda,
    required this.descricao,
  });

  @override
  State<DropdownAluno> createState() => _DropdownAlunoState();
}

class _DropdownAlunoState extends State<DropdownAluno> {
  @override
  Widget build(BuildContext context) {
    var selectedValue;
    return SizedBox(
      height: 42,
      child: DropdownButtonFormField<String>(
        hint: Text(
          widget.descricao,
          style: TextStyle(
              color: ColorApp.verdecinza,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.fromLTRB(widget.esquerda, 0, widget.direita, 0),
          labelText: widget.nome,
          labelStyle: TextStyle(
              color: ColorApp.verdecinza, fontWeight: FontWeight.w600),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorApp.verdePrincipal),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorApp.verdePrincipal),
            borderRadius: BorderRadius.circular(10.0),
          ),
          border: OutlineInputBorder(),
        ),
        iconEnabledColor: ColorApp.verdePrincipal,
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
