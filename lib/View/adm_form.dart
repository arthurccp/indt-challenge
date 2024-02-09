import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indt_challenge/Model/user.dart';
import 'package:indt_challenge/View/filed_form.dart';
import 'package:indt_challenge/View/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdmForm extends StatefulWidget {
  const AdmForm({Key? key});

  @override
  State<AdmForm> createState() => _AdmFormState();
}

class _AdmFormState extends State<AdmForm> {
  late TextEditingController controllerlevelUser;
  late TextEditingController controllerName;
  late TextEditingController controllerSurName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;

  @override
  void initState() {
    super.initState();
    controllerlevelUser = TextEditingController();
    controllerName = TextEditingController();
    controllerSurName = TextEditingController();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
    _loadUser();
  }

  @override
  void dispose() {
    controllerlevelUser.dispose();
    controllerName.dispose();
    controllerSurName.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userStrings = prefs.getStringList('users') ?? [];
    if (userStrings.isNotEmpty) {
      // Assuming only one user is stored for simplicity
      User user = User.fromJson(jsonDecode(userStrings.first));
      controllerlevelUser.text = user.level;
      controllerName.text = user.name;
      controllerSurName.text = user.surname;
      controllerEmail.text = user.email;
      controllerPassword.text = user.password;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;
    String title = userProvider.indexUser != null ? "Edit User" : "Create User";

    if (title == "Create User") {
        // Limpar os inputs
        controllerlevelUser.text = "";
        controllerName.text = "";
        controllerSurName.text = "";
        controllerEmail.text = "";
        controllerPassword.text = "";
      }

    void save() {
      User user = User(
        level: controllerlevelUser.text,
        name: controllerName.text,
        surname: controllerSurName.text,
        email: controllerEmail.text,
        password: controllerPassword.text,
      );

      userProvider.saveUser(user);
      Navigator.popAndPushNamed(context, "/admList");
    }

    void clearForm() {
      controllerlevelUser.clear();
      controllerName.clear();
      controllerSurName.clear();
      controllerEmail.clear();
      controllerPassword.clear();
    }

    void clearSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        automaticallyImplyLeading: false, // Remover o botão de voltar
        actions: [
          IconButton(
            onPressed: clearSharedPreferences,
            icon: Icon(Icons.delete_forever),
          ),
          Container(
            child: TextButton(
              child: Text("UserList"),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/admList");
              },
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            margin: EdgeInsets.all(8),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            FieldForm(
              label: "Level",
              isPasword: false,
              controller: controllerlevelUser,
            ),
            FieldForm(
              label: "Name",
              isPasword: false,
              controller: controllerName,
            ),
            FieldForm(
              label: "Surname",
              isPasword: false,
              controller: controllerSurName,
            ),
            FieldForm(
              label: "Email",
              isPasword: false,
              controller: controllerEmail,
            ),
            FieldForm(
              label: "Password",
              isPasword: true,
              controller: controllerPassword,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: save,
                child: Text("Salvar"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: clearForm,
                child: Text("Limpar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
