import 'package:flutter/cupertino.dart';

class CarritoModel {
  static final CarritoModel _instance = CarritoModel._internal();

  factory CarritoModel() => _instance;

  CarritoModel._internal();

  final ValueNotifier<int> cantidad = ValueNotifier<int>(0);

  void anadirItem() {
    cantidad.value++;
  }
}