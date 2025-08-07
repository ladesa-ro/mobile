import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';

class EventoCardProf extends StatelessWidget {
  final int index;

  const EventoCardProf({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: CoresClaras.cinza),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: Colors.primaries[index % Colors.primaries.length],
              ),
              const SizedBox(width: 6),
              Text(
                '${index + 1}ª Etapa',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Início: 08/02'),
          const Text('Término: 23/03'),
          const SizedBox(height: 10),
          const Text('Encerrado'),
        ],
      ),
    );
  }
}
