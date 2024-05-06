import 'package:flutter/material.dart';

class TamanhoTela {
  static double horizontal(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double vertical(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
