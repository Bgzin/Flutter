import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContatoModel {
  //atributos
  String nome;
  String cpf;
  String email;
  String senha;

  //construtor
  ContatoModel({
    required this.nome,
    required this.cpf,
    required this.email,
    required this.senha,
  });

  //mapeamento
  Map<String, dynamic> toMap() {
    return {
      'Nome': nome,
      'CPF': cpf,
      'email': email,
      'senha': senha,
    };
  }

  factory ContatoModel.fromMap(Map<String, dynamic> map) {
    return ContatoModel(
      nome: map['Nome'],
      cpf: map['CPF'],
      email: map['email'],
      senha: map['senha'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database.db');
    return openDatabase(path, version: 1);
  }

  Future<bool> checkUserExists(String email, String senha) async {
    final db = await database;
    var result = await db.query(
      'usuarios', // Use o nome da tabela corretamente
      where: 'email = ? AND senha = ?', // Verifique com base no email e senha
      whereArgs: [email, senha],
    );
    return result.isNotEmpty;
  }
}

// Função assíncrona para verificar o usuário e fazer a navegação
void checkUserAndNavigate(
    BuildContext context, String email, String senha) async {
  // Verifica se o usuário existe no banco de dados
  bool userExists = await DatabaseHelper().checkUserExists(email, senha);

  if (userExists) {
    // Se o usuário existir, navegue para a tela inicial
    Navigator.pushNamed(context, '/home');
  } else {
    // Caso contrário, exiba uma mensagem de erro
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Erro de login',
            style: TextStyle(color: Colors.black), // Cor do texto preto
          ),
          content: Text(
            'Usuário ou senha inválidos.',
            style: TextStyle(color: Colors.black), // Cor do texto preto
          ),
          backgroundColor: Color.fromARGB(255, 255, 3, 3), // Cor de fundo verde
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
