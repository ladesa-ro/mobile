import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:sisgha/app/api/repository.dart';
import 'package:sisgha/app/constants/Icones.dart';
import 'package:sisgha/app/constants/colors.dart';
import 'package:sisgha/app/constants/estilos.dart';
import 'package:sisgha/app/constants/tamanhotela.dart';
import 'package:sisgha/app/views/home/navegacao.dart';
import 'package:sisgha/app/views/login/aluno.dart';
import 'package:sisgha/app/widgets/widget_erro.dart';

Widget elementoVerde(Alignment alignment, double width, double height) {
  BorderRadiusGeometry borderRadius = BorderRadius.zero;
  if (alignment == Alignment.topLeft) {
    borderRadius = BorderRadius.only(
      bottomRight: Radius.circular(height > 810 ? width * 0.26 : width * 0.20),
    );
  } else if (alignment == Alignment.bottomRight) {
    borderRadius = BorderRadius.only(
      topLeft: Radius.circular(height > 810 ? width * 0.26 : width * 0.20),
    );
  }

  return Align(
    alignment: alignment,
    child: Container(
      width: height > 810 ? width * 0.39 : width * 0.32,
      height: height > 810 ? height * 0.20 : height * 0.17,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorApp.VerdePrincipal,
            ColorApp.VerdeClaro,
          ],
        ),
        borderRadius: borderRadius,
      ),
    ),
  );
}

Widget botaoEntrarAluno(context, double tamanhoHorizontal) {
  return SizedBox(
    height: 45,
    width: tamanhoHorizontal * 0.70,
    child: Center(
      child: FilledButton(
        style: estiloBotao(context, 0, 5, 0, 5),
        onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const PaginaAluno(),
            ),
            (route) => false),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: avoid_unnecessary_containers
              Container(
                child: Row(
                  children: [
                    const SizedBox(width: 19),
                    const Iconify(
                      Icones.PersonCheio,
                      color: ColorApp.Branco,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 2,
                      height: 30,
                      color: ColorApp.Branco,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Entrar como Aluno',
                style: estiloTexto(17, peso: FontWeight.w600),
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

Widget recuperarSenha(context, double tamanho) {
  return Container(
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Esqueceu a senha?',
          style: estiloTexto(
            cor: ColorApp.VerdeCinza,
            tamanho > 200 ? 14 : 12,
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
            style: estiloTexto(tamanho > 300 ? 14 : 12,
                cor: ColorApp.VerdePrincipal, peso: FontWeight.w600),
          ),
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
        bool deuCerto = await login(matricula, senha, context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        if (deuCerto) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Navigation(
                initialIndex: 1,
              ),
            ),
          );
        } else {
          senha.clear();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    },
    style: estiloBotao(context, 0, 0.5, 0, 0),
    child: SizedBox(
      height: 45,
      width: TamanhoTela.horizontal(context),
      child: Center(
        child: Text(
          texto,
          style: estiloTexto(18, cor: Colors.white, peso: FontWeight.w600),
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
