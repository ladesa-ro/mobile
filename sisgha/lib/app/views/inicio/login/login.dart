// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/app/core/utils/estilos.dart';
import 'package:sisgha/app/core/utils/imagens.dart';
import 'package:sisgha/app/core/utils/responsividade.dart';
import 'package:sisgha/app/core/utils/tamanhos.dart';
import 'package:sisgha/app/data/providers/dados_professor.dart';

import 'package:sisgha/app/views/inicio/login/widgets_estilos.dart';
import 'package:sisgha/app/views/widgets_globais/botton_app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/Icones.dart';
import '../../../core/utils/colors.dart';
import '../../../data/api/repository.dart';
import '../../widgets_globais/widget_erro.dart';

class PaginaLogin extends StatelessWidget {
  const PaginaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          elementoVerde(Alignment.topLeft),
          elementoVerde(Alignment.bottomRight),
          CorpoLogin()
        ],
      ),
    );
  }
}

class CorpoLogin extends StatefulWidget {
  const CorpoLogin({super.key});

  @override
  State<CorpoLogin> createState() => _CorpoLoginState();
}

class _CorpoLoginState extends State<CorpoLogin> {
  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _senhaVisivel = true;

  void alternarVisibilidadeSenha() {
    setState(() {
      _senhaVisivel = !_senhaVisivel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          height: TamanhoTela.vertical(context),
          width: TamanhoTela.horizontal(context),
          child: Padding(
            padding: Tamanhos.margem(context) * 2.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageApp.logo_sigha_sem_barra,
                  width: TamanhoTela.horizontal(context) -
                      (Tamanhos.margem(context).horizontal * 4),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: TamanhoTela.vertical(context) * 0.03),
                      inputMatricula(),
                      SizedBox(height: TamanhoTela.vertical(context) * 0.02),
                      inputSenha(),
                      SizedBox(height: TamanhoTela.vertical(context) * 0.01),
                      recuperarSenha(context),
                      SizedBox(height: TamanhoTela.vertical(context) * 0.01),
                      botaoEntrar(context),
                      SizedBox(height: TamanhoTela.vertical(context) * 0.02),
                      botaoEntrarAluno(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox botaoEntrarAluno(BuildContext context) {
    return SizedBox(
      height: Tamanhos.aluturaBotoes(context),
      width: double.infinity,
      child: Center(
        child: FilledButton(
          style: estiloBotao(context),
          onPressed: () => Navigator.pushNamed(context, "/acessoAluno"),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Row(
                    children: [
                      const SizedBox(width: 19),
                      Icon(
                        Icones.PersonCheio,
                        color: ColorApp.Branco,
                        size: 3.h,
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 2,
                        height: 3.h,
                        color: ColorApp.Branco,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  'Entrar como Aluno',
                  style: estiloTexto(16, peso: FontWeight.w600),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FilledButton botaoEntrar(BuildContext context) {
    return FilledButton(
      onPressed: () async {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (formKey.currentState!.validate()) {
          bool deuCerto =
              await login(matriculaController, senhaController, context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          if (deuCerto) {
            DadosProfessor.iniciarProvider(context);
          } else {
            senhaController.clear();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      style: estiloBotao(context),
      child: SizedBox(
        height: Tamanhos.aluturaBotoes(context),
        width: double.infinity,
        child: Center(
          child: Text(
            'Entrar',
            style: estiloTexto(16, cor: Colors.white, peso: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Container recuperarSenha(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Esqueceu a senha?',
            style: estiloTexto(
              cor: ColorApp.VerdeCinza,
              14,
              peso: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 3),
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => dialogoDeErro(context),
            ),
            child: Text(
              'Clique aqui',
              style: estiloTexto(15,
                  cor: ColorApp.VerdePrincipal, peso: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField inputMatricula() {
    return TextFormField(
      controller: matriculaController,
      decoration: inputDecoration(context, 'Matrícula'),
      validator: (value) =>
          verificacao(value, 'Campo Obrigatorio', text2: 'Matrícula Inválida'),
      keyboardType: TextInputType.number,
    );
  }

  TextFormField inputSenha() {
    return TextFormField(
      controller: senhaController,
      decoration: inputDecoration(context, 'Senha',
          suffixIcon:
              iconeVisibilidadeSenha(alternarVisibilidadeSenha, _senhaVisivel)),
      validator: (value) => verificacao(value, 'Campo Obrigatorio'),
      keyboardType: TextInputType.text,
      obscureText: _senhaVisivel,
    );
  }

  dynamic verificacao(dynamic value, String text1, {String? text2}) {
    if (value == null || value.isEmpty) {
      setState(() {});
      return text1;
    } else if (text2 != null && value.contains(" ")) {
      setState(() {});
      return text2;
    } else {
      setState(() {});
      return null;
    }
  }
}

// Scaffold(
//   resizeToAvoidBottomInset: false,
//   backgroundColor: Colors.white,
//   body: MediaQuery.removeViewInsets(
//     removeTop: true,
//     context: context,
//     child: Stack(
//       children: [
//         elementoVerde(Alignment.topLeft, larguraTela, alturaTela),
//         elementoVerde(Alignment.bottomRight, larguraTela, alturaTela),
//         Center(
//           child: SingleChildScrollView(
//             child: SizedBox(
//               width: larguraTela,
//               height: alturaTela,
//               child: Padding(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: larguraTela * 0.08),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: alturaTela * 0.1,
//                       child: Image.asset(
//                         ImageApp.logo_sigha_sem_barra,
//                         width: larguraTela * 0.6,
//                       ),
//                     ),
//                     SizedBox(height: alturaTela * 0.03),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 40),
//                       child: Form(
//                         key: formKey,
//                         child: Column(
//                           children: [
//                             _campoDeEntrada(
//                                 'Matrícula',
//                                 TextInputType.number,
//                                 matriculaController,
//                                 alturaTela),
//                             _campoDeEntradaSenha(
//                                 'Senha',
//                                 TextInputType.text,
//                                 senhaController,
//                                 alturaTela),
     //                        recuperarSenha(context),
//                             SizedBox(height: alturaTela * 0.03),
//                             botaoEntrar(
//                                 'Entrar',
//                                 context,
//                                 formKey,
//                                 matriculaController,
//                                 senhaController,
//                                 alturaTela),
//                             SizedBox(height: alturaTela * 0.03),
//                             botaoEntrarAluno(
//                                 context, alturaTela, larguraTela),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// );

// Widget _campoDeEntrada(String labelText, TextInputType inputType,
//     TextEditingController controller, double altura) {
//   return AnimatedContainer(
//     margin: EdgeInsets.only(bottom: 7),
//     duration: const Duration(milliseconds: 300),
//     height: altura * 0.07,
//     child: TextFormField(
//       controller: controller,
//       validator: (value) => verificacao(value, "Campo obrigatorio",
//           text2: "Matricula invalida"),
//       decoration: inputDecoration(labelText),
//       keyboardType: inputType,
//     ),
//   );
// }

// Widget _campoDeEntradaSenha(String labelText, TextInputType inputType,
//     TextEditingController controller, double altura) {
//   return AnimatedContainer(
//     duration: const Duration(milliseconds: 300),
//     height: altura * 0.07,
//     margin: EdgeInsets.only(bottom: 7),
//     child: TextFormField(
//       controller: controller,
//       validator: (value) => verificacao(value, "Campo Obrigatorio"),
//       obscureText: _senhaVisivel,
//       decoration: inputDecoration(labelText,
//           suffixIcon: iconeVisibilidadeSenha(
//               alternarVisibilidadeSenha, _senhaVisivel)),
//       keyboardType: inputType,
//     ),
//   );
// }

