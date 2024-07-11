import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/botton_sheat.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/button_style_edit.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/circle_avatar.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/dados_do_usuario.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/navegacao_switch.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/widgets_perfil.dart';

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
                  top: 20,
                  right: 10,
                  child: ElevatedButton(
                    style: buttonStyleEdit(ColorApp.Branco),
                    child: const Iconify(
                      Icones.Lapiz,
                      size: 14,
                      color: ColorApp.Preto,
                    ),
                    onPressed: () => {
                      bottomSheat(context),
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: circleAvatar(context),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: dadosUsuario(context),
          ),
          Container(
            margin: const EdgeInsets.only(left: 50, right: 50, top: 10),
            child: Column(
              children: [
                formulario(textoFlutuante: 'Nome', informacoes: 'Professor'),
                const SizedBox(
                  height: 5,
                ),
                formulario(
                    textoFlutuante: 'Email',
                    informacoes: 'professorlosninor1234@gmail.com'),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    formularioLinha(
                        textoFlutuante: 'Matricula',
                        informacoes: '191981989',
                        context: context),
                    const Spacer(),
                    formularioLinha(
                        textoFlutuante: 'Função',
                        informacoes: 'Professor',
                        context: context),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: TamanhoTela.vertical(context),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const NavSwitch(),
          )
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
