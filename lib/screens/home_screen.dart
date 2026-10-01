import 'package:flutter/material.dart';

import 'catalogo_screen.dart';
import '../data/resource_data.dart';
import 'favorites_screen.dart';
import 'galeria_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int indice = 0;
  final Set<int> favoritos = {};
  final Set<int> completados = {};
  AppLifecycleState? estadoActual;
  final List<AppLifecycleState> historial = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF231C6B),

      body: switch (indice) {
        0 => construirInicio(),
        1 => CatalogoScreen(
          favoritos: favoritos,
          cambiarFavorito: cambiarFavorito,
          completados: completados,
          cambiarCompletado: cambiarCompletado,
        ),
        2 => FavoritesScreen(
          favoritos: favoritos,
          cambiarFavorito: cambiarFavorito,
          completados: completados,
          cambiarCompletado: cambiarCompletado,
        ),
        3 => GaleriaScreen(
          favoritos: favoritos,
          cambiarFavorito: cambiarFavorito,
          completados: completados,
          cambiarCompletado: cambiarCompletado,
        ),
        4 => ProgresoScreen(
          completados: completados,
          ultimoestado: estadoActual,
          historial: historial,
        ),

        _ => construirInicio(),
      },
      bottomNavigationBar: NavigationBar(
        selectedIndex: indice,

        onDestinationSelected: (index) {
          setState(() {
            indice = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Catálogo',
          ),
          NavigationDestination(
            icon: Icon(Icons.star),
            selectedIcon: Icon(Icons.star_border),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_library),
            selectedIcon: Icon(Icons.photo_album_rounded),
            label: 'Galeria',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Progreso',
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    estadoActual = WidgetsBinding.instance.lifecycleState;
    if (estadoActual != null) {
      historial.add(estadoActual!);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      estadoActual = state;

      historial.add(state);

      if (historial.length > 5) {
        historial.removeAt(0);
      }
    });
  }

  String obtenerMensajeEstado() {
    switch (estadoActual) {
      case AppLifecycleState.resumed:
        return 'La aplicación está activa';

      case AppLifecycleState.inactive:
        return 'La aplicación está inactiva';

      case AppLifecycleState.paused:
        return 'La aplicación está en pausa';

      case AppLifecycleState.detached:
        return 'La aplicación está desconectada';

      default:
        return 'Estado desconocido';
    }
  }

  Widget construirInicio() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          const Text(
            'ExRE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Explorador de recursos de estudio',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),

          const SizedBox(height: 30),

          Row(
            children: [
              Expanded(
                child: Card(
                  color: const Color(0xFF2E2789),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          '${recursos.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Recursos',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Card(
                  color: const Color(0xFF2E2789),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          '${favoritos.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Favoritos',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Card(
                  color: const Color(0xFF2E2789),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          '${completados.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Completados',
                          maxLines: 1,
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            'Accesos rápidos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CatalogoScreen(
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
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Icon(Icons.menu_book, color: Colors.white, size: 30),
                          SizedBox(height: 8),
                          Text(
                            'Catálogo',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GaleriaScreen(
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
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Icon(Icons.grid_view, color: Colors.white, size: 30),
                          SizedBox(height: 8),
                          Text(
                            'Galería',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritesScreen(
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
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Icon(Icons.favorite, color: Colors.white, size: 30),
                          SizedBox(height: 8),
                          Text(
                            'Favoritos',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgresoScreen(
                          completados: completados,
                          ultimoestado: estadoActual,
                          historial: historial,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: const Color(0xFF2E2789),
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Icon(Icons.bar_chart, color: Colors.white, size: 30),
                          SizedBox(height: 8),
                          Text(
                            'Progreso',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          Card(
            color: const Color(0xFF2E2789),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.phone_android,
                    color: Colors.white,
                    size: 30,
                  ),

                  const SizedBox(width: 15),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Estado de la aplicación',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        estadoActual?.name ?? 'Desconocido',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        obtenerMensajeEstado(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void cambiarFavorito(int id) {
    setState(() {
      if (favoritos.contains(id)) {
        favoritos.remove(id);
      } else {
        favoritos.add(id);
      }
    });
  }

  void cambiarCompletado(int id) {
    setState(() {
      if (completados.contains(id)) {
        completados.remove(id);
      } else {
        completados.add(id);
      }
    });
  }
}
