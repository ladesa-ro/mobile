import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/core/utils/icones.dart';
import 'package:sizer/sizer.dart';

import '../core/utils/estilos.dart';
import '../viewmodels/calendario_funcionalidades.dart';
import '../views/professor/calendario/calendario.dart';

Widget cardCalendario(
    DateTime? selectedDay, double tamanho, double largura, ColorScheme tema) {
  return Consumer<CalendarioFuncionalidades>(
    builder: (context, provider, _) {
      List eventos = [];

      if (selectedDay == null) {
        // Nenhum dia selecionado → mostrar todos os eventos do mês atual
        final agora = DateTime.now();
        final mesAtual = agora.month;
        final anoAtual = agora.year;

        eventos =
            provider.tudoJunto.values.expand((lista) => lista).where((evento) {
          final dataEvento = converterData(evento.dataInicio);

          return dataEvento.month == mesAtual && dataEvento.year == anoAtual;
        }).toList();
      } else {
        // Dia selecionado → mostrar eventos só daquele dia
        final data = normalizarData(selectedDay);
        eventos = provider.tudoJunto[data] ?? [];
      }

      if (eventos.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: tamanho * 0.03),
          child: Text(
            "Nenhum evento para este dia.",
            style: estiloTexto(15, cor: tema.onPrimary, peso: FontWeight.bold),
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: tema.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: tema.onSecondary, // cor da borda
                width: 1, // a espreçura
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 13.sp,
                        width: 13.sp,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: evento.cor),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        evento.titulo,
                        style: estiloTexto(
                          15,
                          cor: tema.primary,
                          peso: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(evento.dataInicio,
                      style: estiloTexto(15,
                          cor: tema.primary, peso: FontWeight.bold)),
                  Text(evento.dataTermino!,
                      style: estiloTexto(15,
                          cor: tema.primary, peso: FontWeight.bold)),
                  SizedBox(height: 2.h),
                  Text(evento.tempo!,
                      style: estiloTexto(15,
                          cor: tema.primary, peso: FontWeight.bold)),
                  SizedBox(height: 1.h),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(tema.surface),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            side:
                                BorderSide(color: tema.onSecondary, width: 0.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                        minimumSize: WidgetStatePropertyAll(
                          Size(20.w, 5.h),
                        ),
                        maximumSize: WidgetStatePropertyAll(Size(20.w, 5.h))),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Iconify(
                          Icones.sino,
                          size: 18.sp,
                          color: tema.onSecondaryFixedVariant,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          'Local',
                          style: estiloTexto(15,
                              cor: tema.primary, peso: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

DateTime converterData(String dataBruta) {
  // Remove "Início:" ou espaços extras
  dataBruta = dataBruta.replaceAll("Início:", "").trim();

  // Exemplo esperado: "16/11 às 00:00"
  final partes = dataBruta.split(' ');
  final dataSplit = partes[0].split('/');

  final dia = int.tryParse(dataSplit[0]) ?? 1;
  final mes = int.tryParse(dataSplit[1]) ?? 1;
  final ano = DateTime.now().year;

  // hora
  String horaStr = "00:00";
  if (partes.length > 2) {
    horaStr = partes[2];
  }
  final horaSplit = horaStr.split(':');
  final hora = int.tryParse(horaSplit[0]) ?? 0;
  final minuto = int.tryParse(horaSplit[1]) ?? 0;

  return DateTime(ano, mes, dia, hora, minuto);
}
