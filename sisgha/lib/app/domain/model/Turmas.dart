class Turma {
  final String id;
  final String slug;

  Turma({
    required this.id,
    required this.slug
  });

  factory Turma.fromJson(Map<String, dynamic> json) {
    return Turma(
      id: json['id'].toString(),
      slug: json['slug'].toString(),
    );
  }
}
