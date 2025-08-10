import 'package:flutter/material.dart';

class AutoFontSizeText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double maxWidth;
  final double maxFontSize;
  final double minFontSize;

  const AutoFontSizeText({
    super.key,
    required this.text,
    required this.style,
    required this.maxWidth,
    this.maxFontSize = 16,
    this.minFontSize = 8,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = maxFontSize;

    final TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    while (fontSize >= minFontSize) {
      painter.text = TextSpan(text: text, style: style.copyWith(fontSize: fontSize));
      painter.layout(maxWidth: maxWidth);

      if (painter.didExceedMaxLines || painter.width > maxWidth) {
        fontSize -= 1;
      } else {
        break;
      }
    }

    return Text(
      text,
      style: style.copyWith(fontSize: fontSize),
      maxLines: 1,
      overflow: TextOverflow.clip,
      softWrap: false,
    );
  }
}
