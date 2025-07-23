import 'package:flutter/material.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

class WidgetAppBar extends StatelessWidget {
  const WidgetAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFffffff),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Título centrado horizontalmente
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xFF0D5030),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Botones alineados a la derecha, centrados verticalmente y con padding
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 12), // Espacio desde el borde derecho
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.minimize, size: 13, color: Color(0xFF0D5030)),
                    onPressed: () {
                      WindowManagerPlus.current.minimize();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.crop_square, size: 13, color: Color(0xFF0D5030)),
                    onPressed: () async {
                      bool isMax = await WindowManagerPlus.current.isMaximized();
                      if (isMax) {
                        await WindowManagerPlus.current.unmaximize();
                      } else {
                        await WindowManagerPlus.current.maximize();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 13, color: Color(0xFF0D5030)),
                    onPressed: () {
                      WindowManagerPlus.current.close();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}