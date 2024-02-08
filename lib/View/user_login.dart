import 'package:flutter/material.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({Key? key});

  // Função para realizar o login
  void login(BuildContext context, String username, String password) {
    // Substitua esta lógica com sua própria validação de credenciais
    // Aqui, estou apenas comparando com credenciais fixas.
    if (username == 'admin' && password == 'admin') {
      // Se as credenciais estiverem corretas, navegue para a próxima tela.
      Navigator.pushNamed(context, '/createAdm');
    } else {
      // Caso contrário, exiba uma mensagem de erro.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro de login'),
            content: Text('Credenciais inválidas. Por favor, tente novamente.'),
            actions: [
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

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  login(
                    context,
                    usernameController.text,
                    passwordController.text,
                  );
                },
                child: Text("Login"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Não possui cadastro? ",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, "/createUser");
              },
              child: Text(
                "Cadastre-se",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserLogin(),
  ));
}
