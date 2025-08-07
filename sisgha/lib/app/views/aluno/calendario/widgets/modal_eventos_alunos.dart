import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';
import 'package:sisgha/app/views/aluno/calendario/widgets/CampoPesquisaEventos.dart';
import 'package:sisgha/app/views/aluno/calendario/widgets/EventoCard.dart';
import 'package:sisgha/app/views/aluno/calendario/widgets/ModalEventos.dart';

class ModalEventosAlunos extends StatefulWidget {
  const ModalEventosAlunos({super.key});

  @override
  State<ModalEventosAlunos> createState() => _ModalEventosAlunosState();
}

class _ModalEventosAlunosState extends State<ModalEventosAlunos> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _isFocused = false;
  bool _isEmpty = true;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    _controller.addListener(() {
      setState(() {
        _isEmpty = _controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.6,
        widthFactor: 0.90,
        child: Container(
          decoration: const BoxDecoration(
            color: CoresClaras.branco,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ModalEventos(),
              CampoPesquisaEventos(
                focusNode: _focusNode,
                controller: _controller,
                isFocused: _isFocused,
                isEmpty: _isEmpty,
              ),
              const SizedBox(height: 15),
              Expanded(
                child: RawScrollbar(
                  controller: _scrollController,
                  thumbVisibility: true,
                  trackVisibility: true,
                  thickness: 5,
                  radius: const Radius.circular(10),
                  trackColor: CoresClaras.verdeclarinho,
                  thumbColor: CoresClaras.verdebotao,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return EventoCard(index: index);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
