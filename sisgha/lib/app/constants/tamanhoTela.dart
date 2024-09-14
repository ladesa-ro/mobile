import 'package:flutter/material.dart';

class TamanhoTela {
  TamanhoTela(BuildContext context);

  static double horizontal(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double vertical(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
