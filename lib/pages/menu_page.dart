import 'dart:convert';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import '../recursos/carrito_model.dart';
import '../recursos/widgetAppBar.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int cantidadEnCesta = 0;

  @override
  void initState() {
    super.initState();
    // Escuchar cambios en la cantidad del carrito
    CarritoModel().cantidad.addListener(() {
      setState(() {
        cantidadEnCesta = CarritoModel().cantidad.value;
      });
    });
  }

  Future<void> abrirVentanaProducto(String nombre) async {
    // Esperas la creación de la ventana
    final window = await DesktopMultiWindow.createWindow(
      jsonEncode({'name': nombre}),
    );

    await window.setFrame(Rect.fromLTWH(100, 100, 600, 400));
    await window.center();
    await window.setTitle("Añadir al carrito");
    await window.show();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WidgetAppBar(title: 'Tienda'),
              const SizedBox(height: 130),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Frutas y verduras',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0D5030),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Row(
                  children: [
                    const SizedBox(width: 50),
                    GestureDetector(
                      onTap: () => abrirVentanaProducto('Fresa'),
                      child: Image.asset('assets/fresa.png', width: 150, height: 200),
                    ),
                    const SizedBox(width: 80),
                    GestureDetector(
                      onTap: () => abrirVentanaProducto('Kiwi'),
                      child: Image.asset('assets/kiwi.png', width: 150, height: 200),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (cantidadEnCesta > 0)
            Positioned(
              bottom: 20,
              right: 20,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Icon(Icons.shopping_cart, size: 40, color: Colors.green[700]),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        cantidadEnCesta.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}