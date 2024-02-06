import 'package:flutter/material.dart';
import 'package:sisgha_mobile/pages/barra_top.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(height: 80),
      body: Column(
        children: [
          FilledButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.calendar_month),
                ],
              ))
        ],
      ),
    );
  }
}
