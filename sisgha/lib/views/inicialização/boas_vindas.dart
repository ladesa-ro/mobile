import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisgha/domain/logic/iniciar_providers_gerais.dart';

import '../../viewmodels/calendario_funcionalidades.dart';
import '../../viewmodels/dados_professor.dart';
import '../../viewmodels/escolha_horarios_alunos.dart';
import '../../widgets/progress_indicator.dart';
import '../../widgets/widget_erro.dart';
import '../login/login_page.dart';

class BoasVindasPage extends StatefulWidget {
  const BoasVindasPage({super.key});

  @override
  State<BoasVindasPage> createState() => _BoasVindasPageState();
}

class _BoasVindasPageState extends State<BoasVindasPage> {
  @override
  void initState() {
    super.initState();
    _iniciar();
  }

  Future<void> _iniciar() async {
    try {
      final sucesso = await inicicarProvidersGerais(
        horariosAlunos: context.read<EscolhaHorariosAlunos>(),
        dadosProfessor: context.read<DadosProfessor>(),
        calendario: context.read<CalendarioFuncionalidades>(),
      );

      if (!mounted) return;

      if (sucesso) {
        await context.read<DadosProfessor>().iniciarProvider(context, true);
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const PaginaLogin()),
        );
      }
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (ctx) => dialogoDeErro(ctx, null),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Progressindicator(tamanho: 200),
      ),
    );
  }
}
