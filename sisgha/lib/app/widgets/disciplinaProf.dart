import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';

class Disciplinaprof extends StatefulWidget {
  final String materia;
  final String turma;
  final String horario;

  const Disciplinaprof({
    super.key,
    required this.materia,
    required this.turma,
    required this.horario,
  });

  @override
  State<Disciplinaprof> createState() => _DisciplinaprofState();
}

class _DisciplinaprofState extends State<Disciplinaprof> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 0),
      padding: const EdgeInsets.only(left: 12, right: 5),
      height: 85,
      decoration: BoxDecoration(
        border: Border.all(color: ColorApp.VerdeCinza, width: 2),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.materia),
              Text(widget.turma),
              Text('Horario: ${widget.horario}'),
            ],
          ),
          const Spacer(),
          const Iconify(
            Icones.Relogio,
            color: ColorApp.VerdePrincipal,
          ),
        ],
      ),
    );
  }
}
