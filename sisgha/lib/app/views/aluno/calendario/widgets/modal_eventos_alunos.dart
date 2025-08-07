import 'package:flutter/material.dart';
import 'package:sisgha/app/core/utils/colors.dart';

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
              // Topo
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 24,
                          color: CoresClaras.verdeBordas,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Listagem de Eventos',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),

              // Campo de busca
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 12),
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: (_isFocused || !_isEmpty)
                              ? null
                              : 'Digite o nome do evento ...',
                          suffixIcon: Icon(
                            Icons.search,
                            color: _isFocused
                                ? CoresClaras.verdeBordas
                                : CoresClaras.cinza,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: CoresClaras.cinza),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: CoresClaras.cinza),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: CoresClaras.cinza),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: 0,
                      child: Container(
                        color: CoresClaras.branco,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          'Pesquisar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: _isFocused
                                ? CoresClaras.verdeBordas
                                : CoresClaras.cinza,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Lista de eventos
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
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: CoresClaras.cinza),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle,
                                    size: 10,
                                    color: Colors.primaries[
                                        index % Colors.primaries.length]),
                                const SizedBox(width: 6),
                                Text('${index + 1}ª Etapa',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text('Início: 08/02'),
                            const Text('Término: 23/03'),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Encerrado'),
                          ],
                        ),
                      );
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
