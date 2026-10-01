import 'package:flutter/material.dart';

import '../models/resource.dart';

class DetalleScreen extends StatefulWidget {
  final Recurso recurso;
  final Set<int> favoritos;
  final Function(int) cambiarFavorito;
  final Set<int> completados;
  final Function(int) cambiarCompletado;

  const DetalleScreen({
    super.key,
    required this.recurso,
    required this.favoritos,
    required this.cambiarFavorito,
    required this.cambiarCompletado,
    required this.completados,
  });

  @override
  State<DetalleScreen> createState() => _DetalleScreenState();
}

class _DetalleScreenState extends State<DetalleScreen> {
  @override
  Widget build(BuildContext context) {
    final esFavorito = widget.favoritos.contains(widget.recurso.id);
    final esCompletado = widget.completados.contains(widget.recurso.id);
    return Scaffold(
      backgroundColor: const Color(0xFF231C6B),

      appBar: AppBar(
        title: const Text('Detalle'),
        backgroundColor: const Color(0xFF231C6B),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: const Color(0xFF2E2789),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.open_in_new, color: Colors.white, size: 45),
                const SizedBox(height: 12),
                const Text(
                  'Acceder al recurso',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                Text(
                  widget.recurso.tipo,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          Text(
            widget.recurso.titulo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Descripcion',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            widget.recurso.descripcion,
            style: TextStyle(color: Colors.white70, fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 25),

          const Text(
            'Detalles',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Card(
            color: const Color(0xFF2E2789),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.white70),
                      const SizedBox(width: 10),
                      Text(
                        'Autor: ${widget.recurso.autor}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(Icons.category, color: Colors.white70),
                      const SizedBox(width: 10),
                      Text(
                        'Categoría: ${widget.recurso.categoria}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(Icons.timer, color: Colors.white70),
                      const SizedBox(width: 10),
                      Text(
                        'Duración: ${widget.recurso.duracionMinutos} min',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(Icons.school, color: Colors.white70),
                      const SizedBox(width: 10),
                      Text(
                        'Nivel: ${widget.recurso.nivel}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      const Icon(
                        Icons.insert_drive_file,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Tipo: ${widget.recurso.tipo}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                widget.cambiarFavorito(widget.recurso.id);
              });
            },
            icon: Icon(esFavorito ? Icons.favorite : Icons.favorite_border),
            label: Text(
              esFavorito ? 'Quitar de favoritos' : 'Agregar a favoritos',
            ),
          ),
          const SizedBox(height: 12),

          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                widget.cambiarCompletado(widget.recurso.id);
              });
            },
            icon: Icon(
              esCompletado ? Icons.check_circle : Icons.check_circle_outline,
            ),
            label: Text(
              esCompletado ? 'Marcar como pendiente' : 'Marcar como completado',
            ),
          ),
        ],
      ),
    );
  }
}
