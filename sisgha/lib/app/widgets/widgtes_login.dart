import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhoTela.dart';
import 'package:sisgha/app/views/home/navegacao.dart';
import 'package:sisgha/app/views/login/aluno.dart';

Widget elementoVerde(Alignment alignment, double width, double height) {
  BorderRadiusGeometry borderRadius = BorderRadius.zero;
  if (alignment == Alignment.topLeft) {
    borderRadius = BorderRadius.only(
      bottomRight: Radius.circular(width > 450 ? 120 : 80),
    );
  } else if (alignment == Alignment.bottomRight) {
    borderRadius = BorderRadius.only(
      topLeft: Radius.circular(width > 450 ? 120 : 80),
    );
  }

  return Align(
    alignment: alignment,
    child: Container(
      width: width > 1000 ? width * 0.15 : width * 0.32,
      height: height > 850 ? height * 0.15 : height * 0.17,
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
    height: TamanhoTela.vertical(context) > 750 ? 40 : 35,
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
            const SizedBox(width: 19),
            const Iconify(
              Icones.PersonCheia,
              color: ColorApp.Branco,
            ),
            const SizedBox(width: 15),
            Container(
              width: 2,
              height: 30,
              color: ColorApp.Branco,
            ),
            const SizedBox(width: 20),
            Center(
              child: Text('Entrar como Aluno',
                  style: estiloTexto(
                      TamanhoTela.vertical(context) > 750 ? 21 : 16,
                      peso: FontWeight.w600)),
            )
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
      height: 30,
      width: TamanhoTela.horizontal(context),
      child: Center(
        child: Text(
          texto,
          style: estiloTexto(TamanhoTela.vertical(context) > 750 ? 20 : 15,
              cor: Colors.white, peso: FontWeight.w600),
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
