import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indt_challenge/Model/user.dart';
import 'package:indt_challenge/View/filed_form.dart';
import 'package:indt_challenge/View/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdmForm extends StatefulWidget {
  const AdmForm({Key? key});

  @override
  State<AdmForm> createState() => _UserFormState();
}

class _UserFormState extends State<AdmForm> {
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

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;
    String title = userProvider.indexUser != null ? "Edit User" : "Create User";

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

    void clearSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Voltar ao Início",
                  style: TextStyle(color: Colors.red),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.white.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
