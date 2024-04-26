import 'package:flutter/material.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/views/home/navegacao.dart';
import 'package:sisgha/app/views/login/aluno.dart';

Widget elementoVerde(Alignment alignment, double width, double height) {
  BorderRadiusGeometry borderRadius = BorderRadius.zero;
  if (alignment == Alignment.topLeft) {
    borderRadius = const BorderRadius.only(
      bottomRight: Radius.circular(2000),
    );
  } else if (alignment == Alignment.bottomRight) {
    borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(2000),
    );
  }

  return Align(
    alignment: alignment,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorApp.VerdeEscuro,
            ColorApp.VerdeClaro,
          ],
        ),
        borderRadius: borderRadius,
      ),
    ),
  );
}

Widget botaoEntrarAluno(context) {
  return SizedBox(
    height: 45,
    child: FilledButton(
      style: estiloBotao(context),
      onPressed: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const PaginaAluno(),
          ),
          (route) => false),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(width: 15),
            const Icon(Icons.person),
            const SizedBox(width: 10),
            const Text('|', style: TextStyle(fontSize: 20)),
            const SizedBox(width: 20),
            Text('Entrar como Aluno',
                style: estiloTexto(15, peso: FontWeight.w600)),
          ],
        ),
      ),
    ),
  );
}

Widget recuperarSenha(context) {
  return Container(
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Esqueceu a senha?',
            style: estiloTexto(
              cor: ColorApp.VerdeCinza,
              13,
              peso: FontWeight.w600,
            )),
        const SizedBox(width: 3),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/home'),
          child: Text('Clique aqui',
              style: estiloTexto(13,
                  cor: ColorApp.VerdeEscuro, peso: FontWeight.w600)),
        ),
      ],
    ),
  );
}

Widget botaoEntrar(texto, context, formKey, matricula, senha) {
  return FilledButton(
    onPressed: () async {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (formKey.currentState!.validate()) {
        bool deuCerto = await login(matricula, senha);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        if (deuCerto) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Navigation(
                  initialIndex: 0,
                ),
              ));
        } else {
          senha.clear();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    },
    style: estiloBotao(context),
    child: SizedBox(
      width: double.infinity,
      child: Center(
        child: Text(
          texto,
          style: estiloTexto(15, cor: Colors.white, peso: FontWeight.w600),
        ),
      ),
    ),
  );
}

const snackBar = SnackBar(
  content: Text(
    "Matricula ou senha inválidos",
    textAlign: TextAlign.center,
  ),
);

Widget iconeVisibilidadeSenha(alternarVisibilidadeSenha, senhaVisivel) {
  return IconButton(
    onPressed: alternarVisibilidadeSenha,
    icon: Icon(senhaVisivel
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined),
  );
}
