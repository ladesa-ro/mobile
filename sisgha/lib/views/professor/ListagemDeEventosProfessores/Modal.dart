import 'package:flutter/material.dart';
import 'package:sisgha/core/utils/estilos.dart';

import '../../../core/utils/colors.dart';

class ModalEventosProf extends StatelessWidget {
  const ModalEventosProf({super.key});

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
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 8),
              Text(
                'Listagem De Eventos',
                style: estiloTexto(
                  19,
                  peso: FontWeight.bold,
                  cor: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          IconButton(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
