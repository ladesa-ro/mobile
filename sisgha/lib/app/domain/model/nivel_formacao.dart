class OfertaFormacao {
  final String id;
  final String slug;

  OfertaFormacao({
    required this.id,
    required this.slug,
  });

  factory OfertaFormacao.fromJson(Map<String, dynamic> json) => OfertaFormacao(
        slug: json['slug'],
        id: json['id'],
      );
}
