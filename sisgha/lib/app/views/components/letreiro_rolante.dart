import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/estilos.dart';

class LetreiroRolante extends StatefulWidget {
  const LetreiroRolante({super.key});

  @override
  State<LetreiroRolante> createState() => _LetreiroRolanteState();
}

class _LetreiroRolanteState extends State<LetreiroRolante>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  bool _direcao = true;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    )..addListener(_onAnimate);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScroll();
    });
  }

  void _onAnimate() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final offset = _direcao
        ? _animation.value * maxScroll
        : maxScroll * (1 - _animation.value);

    _scrollController.jumpTo(offset);
  }

  void _startScroll() {
    _animationController.forward().then((_) {
      _direcao = !_direcao;
      Future.delayed(const Duration(milliseconds: 1000), () {
        _animationController.reset();
        _startScroll();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: estiloBorda(
          cor: CoresClaras.verdecinzaBorda,
          radius: 15,
          grossuraBorda: 2,
        ),
        height: 40,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Center(
            child: Text(
              'Técnico Integrado - Informática 2023 - 2023',
              style: estiloTexto(
                17,
                cor: CoresClaras.verdePrincipalTexto,
                peso: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
