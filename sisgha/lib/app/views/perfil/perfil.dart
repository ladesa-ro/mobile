import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/views/perfil/button_style_edit.dart';
import 'package:sisgha/app/views/perfil/circle_avatar.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            width: TamanhoTela.horizontal(context),
            height: 210,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Positioned(
                  child: SizedBox(
                    height: 175,
                    width: TamanhoTela.horizontal(context),
                    //aqui muda a imagem de fundo
                    child: Image.asset(
                      "assets/img/gtr.jpeg",
                      fit: BoxFit.cover,
                      alignment: AlignmentDirectional.bottomCenter,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 0,
                  child: ElevatedButton(
                    style: buttonStyleEdit(ColorApp.Branco),
                    child: const Iconify(
                      Icones.Lapiz,
                      size: 14,
                      color: ColorApp.Preto,
                    ),
                    onPressed: () => {},
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: circleAvatar(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//IconButton(
//   onPressed: () async {
//     bool saiu = await sair();
//     if (saiu) {
//       Navigator.pushReplacement(
//         // ignore: use_build_context_synchronously
//         context,
//         MaterialPageRoute(
//           builder: (context) => const BoasVindasPage(),
//         ),
//       );
//     }
//   },
//   icon: const Icon(
//     Icons.logout_rounded,
//     size: 40,
//     color: Color.fromARGB(255, 0, 0, 0),
//   ),
// ),
