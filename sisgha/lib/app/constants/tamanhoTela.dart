import 'package:flutter/material.dart';

class TamanhoTela {
  TamanhoTela(BuildContext context);

  static double horizontal(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double vertical(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double height(BuildContext context, {double? appBarSize}) {
    return MediaQuery.of(context).size.height -
        (appBarSize ?? 0) -
        MediaQuery.of(context).padding.top -
        vertical(context) * 0.08;
  }
}
