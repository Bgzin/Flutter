import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Model.dart';

class NavigationController {
  // Método estático para navegar para a tela de cadastro
  static void goToCadastro(BuildContext context) {
    Navigator.pushNamed(context, '/cadastro');
  }
}
