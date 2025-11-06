import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

ButtonStyle buttonStyleEdit(Color corDeFundo) {
  return ButtonStyle(
      alignment: Alignment.center,
      padding: const WidgetStatePropertyAll(EdgeInsets.all(5)),
      minimumSize: WidgetStatePropertyAll(Size(5.h, 5.h)),
      maximumSize: WidgetStatePropertyAll(Size(5.h, 5.h)),
      backgroundColor: WidgetStatePropertyAll(corDeFundo),
      shape: const WidgetStatePropertyAll(CircleBorder()));
}

ButtonStyle botaoButtonSheat() {
  return ButtonStyle(
      padding: WidgetStatePropertyAll(EdgeInsets.zero),
      elevation: WidgetStatePropertyAll(0),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder()));
}
