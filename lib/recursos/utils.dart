import 'package:flutter/material.dart';

class Utils {

  // AppBar
  static PreferredSizeWidget divAppBar(String strTitulo, {double height = kToolbarHeight}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        backgroundColor: const Color(0xFFe5dfd4),
        title: Text(
          strTitulo,
          style: const TextStyle(fontSize: 22, color: Color(0xFF70706f)),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
    );
  }
}