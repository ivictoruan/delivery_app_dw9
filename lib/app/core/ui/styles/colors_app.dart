
import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get instance { // pesquisar sobre isto!
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primary => const Color(0XFF007D21);
  Color get secondary => const Color(0XFFF88B0C);
}

extension ColorsAppExtensions on BuildContext { // pesquisar sobre isto!
  ColorsApp get colors => ColorsApp.instance;
}