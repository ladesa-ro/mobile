// ignore: file_names
import 'package:flutter/material.dart';

class TamanhoTela {
  static double horizontal(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double vertical(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
