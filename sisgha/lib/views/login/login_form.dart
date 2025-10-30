// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/views/login/login_viewmodel.dart';
import 'package:sisgha/widgets/widget_botao.dart';
import 'package:sisgha/widgets/widget_erro.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/estilos.dart';
import '../../core/utils/icones.dart';
import '../../core/utils/imagens.dart';
import '../../core/utils/padroes.dart';
import '../../repository/repository.dart';
import '../../viewmodels/dados_professor.dart';
import '../../widgets/progress_indicator.dart';
import 'widgets_estilos.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _CorpoLoginState();
}

class _CorpoLoginState extends State<LoginForm> {
  final TextEditingController matriculaController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context);
    final tema = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          height: Padroes.alturaGeral(),
          width: Padroes.larguraGeral(),
          child: Padding(
            padding: Padroes.margem() * 2.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageApp.logo_sigha_sem_barra,
                  width: Padroes.larguraGeral() -
                      (Padroes.margem().horizontal * 4),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: Padroes.alturaGeral() * 0.03),
                      inputMatricula(tema),
                      SizedBox(height: Padroes.alturaGeral() * 0.02),
                      inputSenha(loginVM, tema),
                      SizedBox(height: Padroes.alturaGeral() * 0.01),
                      recuperarSenha(context, tema),
                      SizedBox(height: Padroes.alturaGeral() * 0.01),
                      botaoEntrar(context, loginVM, tema),
                      SizedBox(height: Padroes.alturaGeral() * 0.02),
                      botaoEntrarAluno(context, tema),
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

  Widget botaoEntrarAluno(BuildContext context, ColorScheme tema) {
    return componenteBotao(
      tema: tema,
      onFuncion: () => Navigator.pushNamed(context, "/acessoAluno"),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 19),
            Icon(
              Icons.person,
              color: tema.primaryFixed,
              size: 3.7.h,
            ),
            const SizedBox(width: 5),
            Container(
              width: 2,
              height: 3.h,
              color: tema.onTertiary,
            ),
            const Spacer(),
            Text(
              'Entrar como Aluno',
              style: estiloTexto(
                16,
                cor: tema.inversePrimary,
                peso: FontWeight.w600,
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget botaoEntrar(
      BuildContext context, LoginViewModel loginVM, ColorScheme tema) {
    return componenteBotao(
      tema: tema,
      onFuncion: () async {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        if (formKey.currentState!.validate()) {
          _mostrarDialogoDeCarregamento(context);
          //logica para verificar os dados
          bool? deuCerto = await loginVM.verificarLogin(
            matriculaController,
            senhaController,
          );
          if (deuCerto == null) {
            // erro de conexão
            showDialog(
              context: context,
              builder: (context) => dialogoDeErro(context, tema),
            );
          } else if (deuCerto) {
            // funcionou corretamente
            await context
                .read<DadosProfessor>()
                .iniciarProvider(context, false);
          } else {
            // dados invalidos
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      child: SizedBox(
        height: Padroes.aluturaBotoes(),
        width: Padroes.larguraGeral(),
        child: Center(
          child: Text(
            'Entrar',
            style: estiloTexto(
              16,
              cor: tema.inversePrimary,
              peso: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Container recuperarSenha(BuildContext context, ColorScheme tema) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Esqueceu a senha?',
            style: estiloTexto(
              cor: tema.tertiary,
              14,
              peso: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 3),
          GestureDetector(
            onTap: () async {
              Repository.teste();
            },
            child: Text(
              'Clique aqui',
              style:
                  estiloTexto(15, cor: tema.onPrimary, peso: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField inputMatricula(ColorScheme tema) {
    return TextFormField(
      cursorColor: tema.onPrimary,
      controller: matriculaController,
      decoration: inputDecoration(context, 'Matrícula'),
      validator: (value) =>
          verificacao(value, 'Campo Obrigatorio', text2: 'Matrícula Inválida'),
      keyboardType: TextInputType.number,
    );
  }

  TextFormField inputSenha(LoginViewModel loginVM, ColorScheme tema) {
    return TextFormField(
      cursorColor: tema.onPrimary,
      controller: senhaController,
      decoration: inputDecoration(context, 'Senha',
          suffixIcon: IconButton(
            onPressed: () => loginVM.alternarVisibilidadeSenha(),
            icon: Iconify(
              loginVM.senhaVisivel
                  ? Icones.visibilidadeSenhaOn
                  : Icones.visibilidadeSenhaOff,
            ),
          )),
      validator: (value) => verificacao(value, 'Campo Obrigatorio'),
      keyboardType: TextInputType.text,
      obscureText: !loginVM.senhaVisivel,
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

  static void _mostrarDialogoDeCarregamento(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => const AlertDialog(
        content: Progressindicator(tamanho: 200),
      ),
    );
  }
}
