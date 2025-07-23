import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import '../recursos/carrito_model.dart';

class CarritoPage extends StatelessWidget {
  final WindowController windowController;
  final Map<dynamic, dynamic> data;

  const CarritoPage({
    super.key,
    required this.windowController,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final String nombre = data['name'] ?? 'producto';

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '¿Quieres añadir "$nombre" a la cesta?',
                style: const TextStyle(fontSize: 16, color: Color(0xFF0D5030)),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await windowController.close();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 30),
                      foregroundColor: const Color(0xFF0D5030),
                    ),
                    child: const Text('No'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () async {
                      CarritoModel().anadirItem();
                      await windowController.close();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(120, 30),
                      foregroundColor: const Color(0xFF0D5030),
                    ),
                    child: const Text('Sí'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}