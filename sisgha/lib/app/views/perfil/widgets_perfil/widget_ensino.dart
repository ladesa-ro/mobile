import 'package:flutter/material.dart';

Widget widgetEnsino() {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          color: Colors.amber,
          height: 100,
          width: 300,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          color: Colors.amber,
          height: 100,
          width: 300,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          color: Colors.amber,
          height: 100,
          width: 300,
        ),
      ],
    ),
  );
}
