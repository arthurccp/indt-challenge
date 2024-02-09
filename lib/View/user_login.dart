import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({Key? key});

  static const String _adminUsername = 'admin';
  static const String _adminPassword = 'admin';

  Future<void> login(BuildContext context, String username, String password) async {
    if (username == _adminUsername && password == _adminPassword) {
      Navigator.pushNamed(context, '/createAdm');
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userStrings = prefs.getStringList('users');

    if (userStrings != null) {
      for (String userString in userStrings) {
        Map<String, dynamic> userMap = jsonDecode(userString);
        String? savedUsername = userMap['name'];
        String? savedPassword = userMap['password'];

        if (username == savedUsername && password == savedPassword) {
          Navigator.pushNamed(context, '/userList');
          return;
        }
      }
    }

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
