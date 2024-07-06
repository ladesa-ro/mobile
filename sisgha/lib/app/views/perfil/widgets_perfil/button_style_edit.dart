import 'package:flutter/material.dart';

ButtonStyle buttonStyleEdit(Color corDeFundo) {
  return ButtonStyle(
    padding: const WidgetStatePropertyAll(EdgeInsets.all(5)),
    minimumSize: const WidgetStatePropertyAll(Size(26, 26)),
    maximumSize: const WidgetStatePropertyAll(Size(26, 26)),
    backgroundColor: WidgetStatePropertyAll(corDeFundo),
  );
}
