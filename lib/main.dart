import 'package:flutter/material.dart';

import 'ViewLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Aqui é onde você desativa o banner de debug
      title: 'Login',
      home: LoginView(), // Definindo LoginView como a tela inicial
    );
  }
}
