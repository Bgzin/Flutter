import 'package:flutter/material.dart';
import 'ViewCadastro.dart'; // Importa a tela de cadastro
import 'BancoDadosCrud.dart'; // Importa a classe BancoDadosCrud
import 'Model.dart'; // Importa o modelo de usuário

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Faça seu login',
          style: TextStyle(
            fontFamily: 'Roboto', // Define a fonte como Roboto
            fontSize: 20, // Define o tamanho da fonte
            fontWeight: FontWeight.bold, // Define o peso da fonte como negrito
            color: Color.fromARGB(
                255, 0, 0, 0), // Define a cor do texto como branca
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 61, 179, 14),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Usuario (Email)'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, digite seu Email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Senha'),
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor, digite sua senha';
              }
              return null;
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              String email = _usernameController.text;
              String senha = _passwordController.text;

              if (await BancoDadosCrud().checkUserByEmailExists(email)) {
                // Usuário com o e-mail fornecido está cadastrado
                // Verifique a senha
                bool senhaCorreta = await DatabaseHelper()
                    .checkUserExists(email, senha); // Substituição aqui

                if (senhaCorreta) {
                  // Senha correta, faça login
                  // Navegue para a tela inicial ou execute a lógica necessária
                  Navigator.pushNamed(context, '/home');
                } else {
                  // Senha incorreta, exiba uma mensagem de erro
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Erro de login'),
                        content: Text('Senha incorreta.'),
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
              } else {
                // Usuário não encontrado
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Erro de login',
                          style: TextStyle(
                              color: Colors.red)), // Cor do título vermelha
                      content: Text('Usuário Encontrado.',
                          style: TextStyle(
                              color: Colors.red)), // Cor do conteúdo vermelha
                      backgroundColor: const Color.fromARGB(
                          255, 0, 0, 0), // Cor de fundo branca
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
            },
            child: Text('Login'),
          ),
          SizedBox(height: 8.0),
          Text(
            "Clique abaixo para Criar Cadastro",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () {
              // Navega para a tela de cadastro ao pressionar o botão "Cadastre-se"
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CadastroView()), // Navega para a tela de cadastro
              );
            },
            child: Text('Cadastre-se'),
          ),
        ],
      ),
    );
  }
}
