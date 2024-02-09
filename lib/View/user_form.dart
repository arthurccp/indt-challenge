import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indt_challenge/Model/user.dart';
import 'package:indt_challenge/View/filed_form.dart';
import 'package:indt_challenge/View/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  String title = "Create User";
  TextEditingController controllerlevelUser = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSurName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    _clearControllers();
  }

  void _clearControllers() {
    controllerlevelUser.clear();
    controllerName.clear();
    controllerSurName.clear();
    controllerEmail.clear();
    controllerPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;

    void save() async {
      User user = User(
        level: controllerlevelUser.text,
        name: controllerName.text,
        surname: controllerSurName.text,
        email: controllerEmail.text,
        password: controllerPassword.text,
      );

      await _saveUser(user, userProvider);
      Navigator.popAndPushNamed(context, "/login");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        actions: [
          Container(
            child: Text(""),
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
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveUser(User user, UserProvider userProvider) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> userStrings = prefs.getStringList('users') ?? [];
    userStrings.add(jsonEncode(user.toJson()));

    await prefs.setStringList('users', userStrings);
  }
}
