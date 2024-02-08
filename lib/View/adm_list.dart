import 'package:flutter/material.dart';
import 'package:indt_challenge/Model/user.dart';
import 'package:indt_challenge/View/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AdmList extends StatefulWidget {
  const AdmList({Key? key});

  @override
  State<AdmList> createState() => _AdmListState();
}

class _AdmListState extends State<AdmList> {
  List<String> userNames = []; // Lista para armazenar apenas os nomes dos usuários

  @override
  void initState() {
    super.initState();
    loadUserNames(); // Carrega os nomes dos usuários ao inicializar o widget
  }

  // Método para carregar apenas os nomes dos usuários
  void loadUserNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userStrings = prefs.getStringList('users');

    if (userStrings != null) {
      setState(() {
        userNames = userStrings.map((userString) {
          User user = User.fromJson(jsonDecode(userString));
          return user.name; // Adiciona apenas o nome à lista
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;

    return Scaffold(
      appBar: AppBar(
        title: Text("ADM List"),
        leading: BackButton(
          onPressed: () {
            userProvider.indexUser = null;
            Navigator.popAndPushNamed(context, "/createAdm");
          },
        ),
      ),
      body: ListView.builder(
        itemCount: userNames.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text(userNames[index]),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  userProvider.indexUser = null;
                  userProvider.userSelected = User(name: userNames[index], level: '', surname: '', email: '', password: '',); // Ajuste necessário
                  userProvider.indexUser = index;
                  Navigator.popAndPushNamed(context, "/createAdm");
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  userProvider.indexUser = null;
                  userProvider.userSelected = User(name: userNames[index], level: '', surname: '', email: '', password: ''); // Ajuste necessário
                  userProvider.indexUser = index;
                  Navigator.popAndPushNamed(context, "/view");
                },
                icon: Icon(Icons.visibility, color: Colors.blue),
              ),
              IconButton(
                onPressed: () {
                  userProvider.indexUser = null;
                  setState(() {
                    userNames.removeAt(index);
                  });
                  saveUserNamesToSharedPreferences(); // Atualiza a lista de nomes salva no SharedPreferences
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para salvar a lista de nomes de usuários no SharedPreferences
  void saveUserNamesToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userStrings = userNames.map((userName) => '{"name": "$userName"}').toList(); // Formata o nome como JSON
    prefs.setStringList('users', userStrings);
  }
}
