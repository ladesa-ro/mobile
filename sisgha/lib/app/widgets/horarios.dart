import 'package:flutter/material.dart';
import 'package:sisgha/app/widgets/disciplinaProf.dart';

class Horarios extends StatefulWidget {
  final String materia;
  final String turma;
  final String horario;

  const Horarios({
    super.key,
    required this.materia,
    required this.turma,
    required this.horario,
  });

  @override
  State<Horarios> createState() => _HorariosState();
}

class _HorariosState extends State<Horarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: 3,
        itemBuilder: (context, index) {
          return disciplinaprof(
              widget.materia, widget.turma, widget.horario, context);
        },
      ),
    );
  }
}
