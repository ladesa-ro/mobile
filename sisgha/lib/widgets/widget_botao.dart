import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget componenteBotao(
    {required ColorScheme tema,
    required Widget child,
    VoidCallback? onFuncion,
    double? width}) {
  return ElevatedButton(
      style: ButtonStyle(
          maximumSize: WidgetStatePropertyAll(Size(width ?? 100.w, 6.5.h)),
          minimumSize: WidgetStatePropertyAll(Size(width ?? 100.w, 6.5.h)),
          shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.sp))),
          backgroundColor:
              WidgetStateProperty.all<Color>(tema.primaryContainer),
          foregroundColor: WidgetStatePropertyAll(tema.inversePrimary)),
      onPressed: onFuncion ?? () {},
      child: child);
}
