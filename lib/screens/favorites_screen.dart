import 'package:flutter/material.dart';

import '../data/resource_data.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final Set<int> favoritos;
  final Function(int) cambiarFavorito;
  final Set<int> completados;
  final Function(int) cambiarCompletado;

  const FavoritesScreen({
    super.key,
    required this.favoritos,
    required this.cambiarFavorito,
    required this.cambiarCompletado,
    required this.completados,
  });

  @override
  Widget build(BuildContext context) {
    final recursosFavoritos = recursos.where((recurso) {
      return favoritos.contains(recurso.id);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF231C6B),

      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: const Color(0xFF231C6B),
        foregroundColor: Colors.white,
      ),

      body: recursosFavoritos.isEmpty
          ? const Center(
              child: Text(
                'No tienes recursos favoritos',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),

              itemCount: recursosFavoritos.length,

              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },

              itemBuilder: (context, index) {
                final recurso = recursosFavoritos[index];

                return Card(
                  color: const Color(0xFF2E2789),

                  child: ListTile(
                    leading: const Icon(
                      Icons.favorite,
                      color: Colors.redAccent,
                    ),

                    title: Text(
                      recurso.titulo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      '${recurso.categoria} • ${recurso.autor}',
                      style: const TextStyle(color: Colors.white70),
                    ),

                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.redAccent),

                      onPressed: () {
                        cambiarFavorito(recurso.id);
                      },
                    ),

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
                  ),
                );
              },
            ),
    );
  }
}
