import 'package:flutter/material.dart';

import '../data/resource_data.dart';

class ProgresoScreen extends StatelessWidget {
  final Set<int> completados;
  final AppLifecycleState? ultimoestado;
  final List<AppLifecycleState> historial;

  const ProgresoScreen({
    super.key,
    required this.completados,
    required this.ultimoestado,
    required this.historial,
  });

  @override
  Widget build(BuildContext context) {
    final int totalRecursos = recursos.length;
    final int totalCompletados = completados.length;
    final int totalPendientes = totalRecursos - totalCompletados;

    final double porcentaje = totalRecursos == 0
        ? 0
        : totalCompletados / totalRecursos;

    final recursosCompletados = recursos.where((recurso) {
      return completados.contains(recurso.id);
    }).toList();
    final categorias = recursos
        .map((recurso) => recurso.categoria)
        .toSet()
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF231C6B),

      appBar: AppBar(
        title: const Text('Progreso'),
        backgroundColor: const Color(0xFF231C6B),
        foregroundColor: Colors.white,
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Progreso general',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Card(
            color: const Color(0xFF2E2789),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${(porcentaje * 100).round()}% completado',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  LinearProgressIndicator(
                    value: porcentaje,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '$totalCompletados',
                              style: const TextStyle(
                                color: Color(0xFFAFFFAA),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Completados',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '$totalPendientes',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Pendientes',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          Card(
            color: const Color(0xFF2E2789),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.phone_android,
                    color: Color(0xFFAFFFAA),
                    size: 30,
                  ),

                  const SizedBox(width: 15),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Estado observado',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        ultimoestado?.name ?? 'Desconocido',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          Card(
            color: const Color(0xFF2E2789),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Historial reciente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ...historial.reversed.map((estado) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            size: 8,
                            color: Color(0xFFAFFFAA),
                          ),

                          const SizedBox(width: 10),

                          Text(
                            estado.name,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 30),

                  const Text(
                    'Progreso por categoría',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...categorias.map((categoria) {
                    final recursosCategoria = recursos.where((recurso) {
                      return recurso.categoria == categoria;
                    }).toList();

                    final completadosCategoria = recursosCategoria.where((
                      recurso,
                    ) {
                      return completados.contains(recurso.id);
                    }).length;

                    final totalCategoria = recursosCategoria.length;

                    final porcentajeCategoria = totalCategoria == 0
                        ? 0.0
                        : completadosCategoria / totalCategoria;

                    return Card(
                      color: const Color(0xFF2E2789),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  categoria,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  '$completadosCategoria / $totalCategoria',
                                  style: const TextStyle(
                                    color: Color(0xFFAFFFAA),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            LinearProgressIndicator(
                              value: porcentajeCategoria,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 30),

                  const SizedBox(height: 30),

                  const Text(
                    'Recursos completados',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (recursosCompletados.isEmpty)
                    const Card(
                      color: Color(0xFF2E2789),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'Todavía no has completado ningún recurso',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    )
                  else
                    ...recursosCompletados.map((recurso) {
                      return Card(
                        color: const Color(0xFF2E2789),
                        child: ListTile(
                          leading: const Icon(
                            Icons.check_circle,
                            color: Color(0xFFAFFFAA),
                          ),

                          title: Text(
                            recurso.titulo,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          subtitle: Text(
                            '${recurso.categoria} • ${recurso.duracionMinutos} min',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
