import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';

class CampoPesquisaEventosProf extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool isFocused;
  final bool isEmpty;

  const CampoPesquisaEventosProf({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.isFocused,
    required this.isEmpty,
  });

  @override
  Widget build(BuildContext context) {
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
                  color:
                      isFocused ? CoresClaras.verdeBordas : CoresClaras.cinza,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: CoresClaras.cinza),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: CoresClaras.cinza),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: CoresClaras.verdeBordas),
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
                  color:
                      isFocused ? CoresClaras.verdeBordas : CoresClaras.cinza,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
