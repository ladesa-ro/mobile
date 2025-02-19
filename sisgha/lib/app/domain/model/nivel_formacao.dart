class NiveisFormacao {
  final String id;
  final String slug;

  NiveisFormacao({
    required this.id,
    required this.slug,
  });

  factory NiveisFormacao.fromJson(Map<String, dynamic> json) => NiveisFormacao(
        slug: json['slug'],
        id: json['id'],
      );
}
