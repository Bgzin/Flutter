import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:projeto_flutter/Model.dart';
import 'package:sqflite/sqflite.dart';
import 'BancoDadosCrud.dart'; // Importa a classe BancoDadosCrud

class CadastroView extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Color.fromARGB(178, 4, 241, 12), // Cor de fundo verde
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Cadastro',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          controller: _nomeController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          controller: _cpfController,
                          decoration: InputDecoration(
                            labelText: 'CPF',
                          ),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          controller: _senhaController,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            _cadastrarUsuario(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.person_add),
                              SizedBox(width: 8.0),
                              Text('Cadastrar'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _cadastrarUsuario(BuildContext context) async {
    String nome = _nomeController.text;
    String cpf = _cpfController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;

    // Verifica se todos os campos estão preenchidos
    if (nome.isNotEmpty &&
        cpf.isNotEmpty &&
        email.isNotEmpty &&
        senha.isNotEmpty) {
      // Cria um novo usuário
      ContatoModel novoUsuario = ContatoModel(
        nome: nome,
        cpf: cpf,
        email: email,
        senha: senha,
      );

      // Chama a função de cadastro do banco de dados
      await BancoDadosCrud().create(novoUsuario);

      // Limpa os campos de entrada após o cadastro
      _nomeController.clear();
      _cpfController.clear();
      _emailController.clear();
      _senhaController.clear();

      // Mostra uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );
    } else {
      // Mostra uma mensagem de erro se algum campo estiver vazio
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, preencha todos os campos.')),
      );
    }
  }
}
