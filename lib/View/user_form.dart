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
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;

    int? index;
    if (userProvider.indexUser != null) {
      index = userProvider.indexUser;
      controllerlevelUser.text = userProvider.userSelected!.level;
      controllerName.text = userProvider.userSelected!.name;
      controllerSurName.text = userProvider.userSelected!.surname;
      controllerEmail.text = userProvider.userSelected!.email;
      controllerPassword.text = userProvider.userSelected!.password;

      setState(() {
        this.title = "Edit User";
      });
    }
    void save() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Salve os dados do usuário usando SharedPreferences
      prefs.setString('leveluser', controllerlevelUser.text);
      prefs.setString('name', controllerName.text);
      prefs.setString('surname', controllerSurName.text);
      prefs.setString('email', controllerEmail.text);
      prefs.setString('password', controllerPassword.text);

      if (index != null) {
        User user = User(
          level: controllerName.text,
          name: controllerName.text,
          surname: controllerName.text,
          email: controllerEmail.text,
          password: controllerPassword.text,
        );
        userProvider.users[index] = user;
      } else {
        User user = User(
          level: controllerName.text,
          name: controllerName.text,
          surname: controllerName.text,
          email: controllerEmail.text,
          password: controllerPassword.text,
        );
        int usersLength = userProvider.users.length;
        userProvider.users.insert(usersLength, user);
      }

      // Após salvar os dados, você pode navegar de volta para a tela de login
      Navigator.popAndPushNamed(context, "/login");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        leading: BackButton(
          onPressed: () {
            userProvider.indexUser = null;
            Navigator.popAndPushNamed(context, "/login");
          },
        ),
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
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
