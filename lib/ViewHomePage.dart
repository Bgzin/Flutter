import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Demo'),
      ),
      body: Center(
        child: Text('Bem vindo a página inicial!'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Login Demo',
    initialRoute: '/',
    routes: {
      '/home': (context) => HomePage(),
    },
  ));
}