import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';

class ModalEventos extends StatelessWidget {
  const ModalEventos({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                color: CoresClaras.verdeBordas,
              ),
              const SizedBox(width: 8),
              const Text(
                'Listagem de Eventos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
