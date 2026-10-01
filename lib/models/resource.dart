class Recurso {
  final int id;
  final String titulo;
  final String categoria;
  final String autor;
  final int duracionMinutos;
  final String nivel;
  final String descripcion;
  final String tipo;

  const Recurso({
    required this.id,
    required this.titulo,
    required this.categoria,
    required this.autor,
    required this.duracionMinutos,
    required this.nivel,
    required this.descripcion,
    required this.tipo,
  });
}
