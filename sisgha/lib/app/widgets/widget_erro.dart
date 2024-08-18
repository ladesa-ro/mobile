import 'package:flutter/material.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/imagens.dart';
import 'package:sisgha/app/constants/tamanhotela.dart';
import 'package:sisgha/app/widgets/widgtes_login.dart';

class WidgetErro extends StatefulWidget {
  const WidgetErro({super.key});

  @override
  State<WidgetErro> createState() => _WidgetErroState();
}

class _WidgetErroState extends State<WidgetErro> {
  @override
  Widget build(BuildContext context) {
    final double larguraTela = TamanhoTela.horizontal(context);
    final double alturaTela = TamanhoTela.vertical(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: MediaQuery.removeViewInsets(
        removeTop: true,
        context: context,
        child: Stack(
          children: [
            elementoVerde(Alignment.topLeft, larguraTela, alturaTela),
            elementoVerde(Alignment.bottomRight, larguraTela, alturaTela),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageApp.imagemErro,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Nenhuma conexão com a internet',
                    style: estiloTexto(16,
                        cor: ColorApp.Preto, peso: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Verifique sua conexão ou',
                    style: estiloTexto(
                      15,
                      cor: ColorApp.Preto,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'tente novamente',
                    style: estiloTexto(
                      15,
                      cor: ColorApp.Preto,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: _estiloBotao(
                        ColorApp.VerdePrincipal, ColorApp.Branco, context),
                    onPressed: () {},
                    child: const Text('Tente novamente'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: _estiloBotao(
                        ColorApp.Branco, ColorApp.VerdePrincipal, context),
                    onPressed: () {},
                    child: const Text('Talvez mais tarde'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

ButtonStyle _estiloBotao(Color corFundo, Color corTexto, context) {
  return ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(corFundo),
    foregroundColor: WidgetStatePropertyAll(corTexto),
    minimumSize: const WidgetStatePropertyAll(Size(300, 50)),
    maximumSize: const WidgetStatePropertyAll(Size(300, 50)),
    shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
  );
}
