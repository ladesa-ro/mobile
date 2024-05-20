import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';

class Horarios extends StatefulWidget {
  const Horarios({super.key});

  @override
  State<Horarios> createState() => _HorariosState();
}

class _HorariosState extends State<Horarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(
                  left: 10, top: 20, right: 10, bottom: 0),
              padding: const EdgeInsets.only(left: 12, right: 5),
              height: 85,
              decoration: BoxDecoration(
                border: Border.all(color: ColorApp.VerdeCinza, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Logica de Programação'),
                      Text('2º B Informatica'),
                      Text('Horario: 8:20 a 9:10'),
                    ],
                  ),
                  Spacer(),
                  Iconify(
                    Icones.Relogio,
                    color: ColorApp.VerdePrincipal,
                  )
                ],
              ),
            );
          }),
    );
  }
}
