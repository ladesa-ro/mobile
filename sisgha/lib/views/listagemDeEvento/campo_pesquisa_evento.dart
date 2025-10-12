import 'package:flutter/material.dart';

import '../../core/utils/cores.dart';

class CampoPesquisaEventos extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool isFocused;
  final bool isEmpty;

  const CampoPesquisaEventos({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.isFocused,
    required this.isEmpty,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 12),
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: (isFocused || !isEmpty)
                    ? null
                    : 'Digite o nome do evento ...',
                suffixIcon: Icon(
                  Icons.search,
                  color: isFocused ? tema.onSurfaceVariant : tema.surfaceTint,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: tema.tertiary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: tema.tertiary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: tema.tertiaryContainer),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
            ),
          ),
          Positioned(
            left: 12,
            top: 0,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                'Pesquisar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isFocused ? tema.tertiaryContainer : tema.tertiary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
