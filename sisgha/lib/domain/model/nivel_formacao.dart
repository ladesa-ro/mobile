class OfertaFormacao {
  final Map<String, String> ofertaFormacao;

  OfertaFormacao({required this.ofertaFormacao});

  factory OfertaFormacao.fromJson(Map<String, dynamic> json) => OfertaFormacao(
      ofertaFormacao: {'nome': '${json['nome']}', 'id': json['id']});
}
