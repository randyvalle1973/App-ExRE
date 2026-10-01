import 'package:flutter/material.dart';

import 'detail_screen.dart';
import '../data/resource_data.dart';

class CatalogoScreen extends StatefulWidget {
  final Set<int> favoritos;
  final Function(int) cambiarFavorito;
  final Set<int> completados;
  final void Function(int) cambiarCompletado;

  const CatalogoScreen({
    super.key,
    required this.favoritos,
    required this.cambiarFavorito,
    required this.completados,
    required this.cambiarCompletado,
  });

  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  String busqueda = '';
  String categoria = 'Todas';
  @override
  Widget build(BuildContext context) {
    final recursosFiltrados = recursos.where((recurso) {
      final coincideBusqueda =
          recurso.titulo.toLowerCase().contains(busqueda.toLowerCase()) ||
          recurso.categoria.toLowerCase().contains(busqueda.toLowerCase()) ||
          recurso.autor.toLowerCase().contains(busqueda.toLowerCase());

      final coincideCategoria =
          categoria == 'Todas' || recurso.categoria == categoria;

      return coincideBusqueda && coincideCategoria;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF231C6B),

      appBar: AppBar(
        title: const Text('Catalogo'),
        backgroundColor: const Color(0xFF231C6B),
        foregroundColor: Colors.white,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar por título, categoría o autor...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF2E2789),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (texto) {
                setState(() {
                  busqueda = texto;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              initialValue: categoria,

              dropdownColor: const Color(0xFF2E2789),

              style: const TextStyle(color: Colors.white),

              decoration: InputDecoration(
                labelText: 'Categoría',
                floatingLabelBehavior: FloatingLabelBehavior.always,

                contentPadding: const EdgeInsets.fromLTRB(16, 26, 16, 10),

                labelStyle: const TextStyle(color: Colors.white70),

                filled: true,
                fillColor: const Color(0xFF2E2789),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),

              items: const [
                DropdownMenuItem(value: 'Todas', child: Text('Todas')),
                DropdownMenuItem(value: 'Flutter', child: Text('Flutter')),
                DropdownMenuItem(value: 'Android', child: Text('Android')),
                DropdownMenuItem(value: 'Layouts', child: Text('Layouts')),
                DropdownMenuItem(
                  value: 'Scrollables',
                  child: Text('Scrollables'),
                ),
                DropdownMenuItem(value: 'Slivers', child: Text('Slivers')),
                DropdownMenuItem(
                  value: 'Navegación',
                  child: Text('Navegación'),
                ),
              ],

              onChanged: (valor) {
                setState(() {
                  categoria = valor!;
                });
              },
            ),
          ),

          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: recursosFiltrados.length,
              itemBuilder: (context, index) {
                final recurso = recursosFiltrados[index];
                IconData iconoTipo;
                if (recurso.tipo.toLowerCase() == 'video') {
                  iconoTipo = Icons.play_circle_fill;
                } else if (recurso.tipo.toLowerCase() == 'lectura') {
                  iconoTipo = Icons.menu_book;
                } else {
                  iconoTipo = Icons.assignment;
                }

                return Card(
                  color: const Color(0xFF2E2789),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleScreen(
                            recurso: recurso,
                            favoritos: widget.favoritos,
                            cambiarFavorito: widget.cambiarFavorito,
                            completados: widget.completados,
                            cambiarCompletado: widget.cambiarCompletado,
                          ),
                        ),
                      );
                    },
                    leading: Icon(
                      iconoTipo,
                      color: const Color(0xFFAFFFAA),
                      size: 32,
                    ),

                    title: Text(
                      recurso.titulo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),

                        Text(
                          'Autor: ${recurso.autor}',
                          style: const TextStyle(color: Colors.white70),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          '${recurso.categoria} • ${recurso.duracionMinutos} min',
                          style: const TextStyle(color: Color(0xFFAFFFAA)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
