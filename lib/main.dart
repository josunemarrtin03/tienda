import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:tienda/pages/carrito_page.dart';
import 'package:tienda/pages/menu_page.dart';
import 'package:window_manager_plus/window_manager_plus.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  await WindowManagerPlus.ensureInitialized(0); // Inicializa window_manager_plus

  if (args.isNotEmpty && args.first == 'multi_window') {
    final windowId = int.tryParse(args[1]);
    if (windowId == null) {
      debugPrint('❌ Error: windowId inválido.');
      return;
    }

    final data = args.length > 2 && args[2].isNotEmpty
        ? jsonDecode(args[2]) as Map<String, dynamic>
        : {};

    final controller = WindowController.fromWindowId(windowId);

    runApp(CarritoPage(
      windowController: controller,
      data: data,
    ));
  } else {
    // Configuración de ventana principal:
    const windowOptions = WindowOptions(
      size: Size(1300, 900),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    await WindowManagerPlus.current.waitUntilReadyToShow(windowOptions, () async {
      await WindowManagerPlus.current.setAsFrameless();
      await WindowManagerPlus.current.center();
      await WindowManagerPlus.current.show();
      await WindowManagerPlus.current.focus();
    });

    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tienda Online',
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
    );
  }
}