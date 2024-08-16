import "package:flutter/material.dart";
import "package:sisgha/app/views/perfil/widgets_perfil/widget_sair.dart";

Widget disponibilidade() {
  return LayoutBuilder(
    builder: (context, constraints) => ListView(
      primary: true,
      padding: EdgeInsets.zero,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: 25,
              bottom: 25,
              left: constraints.maxWidth * 0.08,
              right: constraints.maxWidth * 0.08),
          height: constraints.minHeight * 0.50,
          width: constraints.maxWidth,
          color: Colors.amber,
        ),
        Container(
          margin: EdgeInsets.only(
              bottom: 25,
              left: constraints.maxWidth * 0.08,
              right: constraints.maxWidth * 0.08),
          height: constraints.minHeight * 0.50,
          width: constraints.maxWidth,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
        Container(
          margin: EdgeInsets.only(
              bottom: 25,
              left: constraints.maxWidth * 0.08,
              right: constraints.maxWidth * 0.08),
          height: constraints.minHeight * 0.50,
          width: constraints.maxWidth,
          color: Colors.amber,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widgetQuit(context),
          ],
        ),
        const Spacer(),
      ],
    ),
  );
}
