import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/core/utils/icones.dart';
import 'package:sizer/sizer.dart';

import '../core/utils/colors.dart';
import '../core/utils/estilos.dart';
import '../viewmodels/calendario_funcionalidades.dart';
import '../views/professor/calendario/calendario.dart';

Widget cardCalendario(DateTime selectedDay, double tamanho, double largura) {
  return Consumer<CalendarioFuncionalidades>(
    builder: (context, provider, _) {
      final data = normalizarData(selectedDay);
      final eventos = provider.tudoJunto[data] ?? [];
      if (eventos.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: tamanho * 0.03),
          child: Text(
            "Nenhum evento para este dia.",
            style: estiloTexto(15,
                cor: CoresClaras.verdePrincipal, peso: FontWeight.bold),
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
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: CoresClaras.preto, // cor da borda
                width: 0.5, // a espreçura
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
                          16,
                          cor: CoresClaras.pretoTexto,
                          peso: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(evento.dataInicio,
                      style: estiloTexto(16,
                          cor: CoresClaras.preto, peso: FontWeight.bold)),
                  Text(evento.dataTermino!,
                      style: estiloTexto(16,
                          cor: CoresClaras.preto, peso: FontWeight.bold)),
                  SizedBox(height: 2.h),
                  Text(evento.tempo!,
                      style: estiloTexto(16,
                          cor: CoresClaras.preto, peso: FontWeight.bold)),
                  SizedBox(height: 1.h),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(CoresClaras.branco),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            side: BorderSide(
                                color: CoresClaras.preto, width: 0.5),
                            borderRadius: BorderRadius.circular(5),
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
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(
                          'Local',
                          style: estiloTexto(15,
                              cor: CoresClaras.preto, peso: FontWeight.bold),
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
