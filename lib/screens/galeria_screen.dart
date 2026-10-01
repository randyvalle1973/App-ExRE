import 'package:flutter/material.dart';

import '../data/resource_data.dart';
import 'detail_screen.dart';

class GaleriaScreen extends StatelessWidget {
  final Set<int> favoritos;
  final void Function(int) cambiarFavorito;

  final Set<int> completados;
  final void Function(int) cambiarCompletado;

  const GaleriaScreen({
    super.key,
    required this.favoritos,
    required this.cambiarFavorito,
    required this.completados,
    required this.cambiarCompletado,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF231C6B),

      appBar: AppBar(
        title: const Text('Galería'),
        backgroundColor: const Color(0xFF231C6B),
        foregroundColor: Colors.white,
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(16),

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),

        itemCount: recursos.length,

        itemBuilder: (context, index) {
          final recurso = recursos[index];
          final esFavorito = favoritos.contains(recurso.id);
          final estaCompletado = completados.contains(recurso.id);
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalleScreen(
                    recurso: recurso,
                    favoritos: favoritos,
                    cambiarFavorito: cambiarFavorito,
                    completados: completados,
                    cambiarCompletado: cambiarCompletado,
                  ),
                ),
              );
            },

            child: Card(
              color: const Color(0xFF2E2789),

              child: Padding(
                padding: const EdgeInsets.all(14),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (recurso.tipo.toLowerCase() == 'video')
                          const Icon(
                            Icons.play_circle,
                            color: Colors.white70,
                            size: 28,
                          )
                        else if (recurso.tipo.toLowerCase() == 'práctica')
                          const Icon(
                            Icons.assignment,
                            color: Colors.white70,
                            size: 28,
                          )
                        else if (recurso.tipo.toLowerCase() == 'lectura')
                          const Icon(
                            Icons.menu_book,
                            color: Colors.white70,
                            size: 28,
                          )
                        else
                          const Icon(
                            Icons.article,
                            color: Colors.white70,
                            size: 28,
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        if (esFavorito)
                          const Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                            size: 22,
                          ),
                        if (esFavorito && estaCompletado)
                          const SizedBox(width: 6),
                        if (estaCompletado)
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFFAFFFAA),
                            size: 22,
                          ),
                      ],
                    ),

                    const Spacer(),

                    Text(
                      recurso.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      recurso.categoria,
                      style: const TextStyle(
                        color: Color(0xFFAFFFAA),
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '${recurso.duracionMinutos} min',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
