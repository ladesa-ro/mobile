import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/model/userModel.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/botton_sheat.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/button_style_edit.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/dados_do_usuario.dart';
import 'package:sisgha/app/views/perfil/widgets_perfil/navegacao_switch.dart';

class Perfil extends StatelessWidget {
  const Perfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserModel>(
        future: buscarUser(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(value: 100),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text("Erro ao carregar Usuário"),
            );
          } else if (snapshot.hasData) {
            UserModel user = snapshot.data!;
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  width: TamanhoTela.horizontal(context),
                  height: 210,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
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
                          onPressed: () => bottomSheat(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: dadosUsuario(context, user),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 50, right: 50, top: 10),
                  child: Column(
                    children: [
                      formulario(
                          textoFlutuante: 'Nome', informacoes: user.nome),
                      const SizedBox(height: 5),
                      formulario(
                          textoFlutuante: 'Email', informacoes: user.email),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          formularioLinha(
                              textoFlutuante: 'Matricula',
                              informacoes: user
                                  .matricula), // Supondo que matrícula venha do modelo
                          const Spacer(),
                          formularioLinha(
                              textoFlutuante: 'Função',
                              informacoes:
                                  'Professor'), // Supondo que a função venha do modelo
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  height: TamanhoTela.vertical(context),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const NavSwitch(),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Nenhum dado disponível"),
            );
          }
        },
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
