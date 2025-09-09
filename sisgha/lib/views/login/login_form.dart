// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/views/login/login_viewmodel.dart';
import 'package:sisgha/widgets/widget_erro.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/colors.dart';
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
                      inputMatricula(),
                      SizedBox(height: Padroes.alturaGeral() * 0.02),
                      inputSenha(loginVM),
                      SizedBox(height: Padroes.alturaGeral() * 0.01),
                      recuperarSenha(context),
                      SizedBox(height: Padroes.alturaGeral() * 0.01),
                      botaoEntrar(context, loginVM),
                      SizedBox(height: Padroes.alturaGeral() * 0.02),
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

  Widget botaoEntrarAluno(BuildContext context) {
    return ElevatedButton(
      style: Padroes.estiloBotao(context),
      onPressed: () => Navigator.pushNamed(context, "/acessoAluno"),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 19),
            Icon(
              Icons.person,
              color: CoresClaras.branco,
              size: 3.7.h,
            ),
            const SizedBox(width: 5),
            Container(
              width: 2,
              height: 3.h,
              color: CoresClaras.branco,
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
    );
  }

  Widget botaoEntrar(BuildContext context, LoginViewModel loginVM) {
    return FilledButton(
      onPressed: () async {
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
              builder: (context) => dialogoDeErro(context),
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
      style: Padroes.estiloBotao(context),
      child: SizedBox(
        height: Padroes.aluturaBotoes(),
        width: Padroes.larguraGeral(),
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
              cor: CoresClaras.verdecinza,
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
              style: estiloTexto(15,
                  cor: CoresClaras.verdePrincipal, peso: FontWeight.w600),
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

  TextFormField inputSenha(LoginViewModel loginVM) {
    return TextFormField(
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
