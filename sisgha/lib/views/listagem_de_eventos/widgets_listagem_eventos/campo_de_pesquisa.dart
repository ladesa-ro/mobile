import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/core/utils/estilos.dart';
import 'package:sisgha/core/utils/icones.dart';
import 'package:sisgha/viewmodels/calendario_funcionalidades.dart';
import 'package:sizer/sizer.dart';

Widget campoDePesquisa(BuildContext ctx, ColorScheme tema) {
  var prov = Provider.of<CalendarioFuncionalidades>(ctx);
  return TextField(
    cursorColor: tema.onPrimary,
    decoration: InputDecoration(
      labelText: 'Pesquisar',
      labelStyle: estiloTexto(15, cor: tema.tertiary, peso: FontWeight.bold),
      focusedBorder: inputBorder(1, tema),
      enabledBorder: inputBorder(1, tema),
      suffixIcon: Icon(
        Icones.lupa,
        color: tema.secondaryFixed,
        size: 3.h,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onChanged: (value) => prov.aplicarFiltro(value),
  );
}
