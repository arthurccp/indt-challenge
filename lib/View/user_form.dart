import 'package:flutter/material.dart';
import 'package:indt_challenge/Model/user.dart';
import 'package:indt_challenge/View/filed_form.dart';
import 'package:indt_challenge/View/user_provider.dart';


class UserForm extends StatefulWidget {
  const UserForm({super.key});

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
      controllerName.text = userProvider.userSelected!.name;
      controllerEmail.text = userProvider.userSelected!.email;
      controllerPassword.text = userProvider.userSelected!.password;
      print("save");
      setState(() {
        this.title = "Edit User";
      });
    }
    void save() {
      Navigator.popAndPushNamed(context, "/login");

      User user = User(
          level: controllerName.text,
          name: controllerName.text,
          surname: controllerName.text,
          email: controllerEmail.text,
          password: controllerPassword.text);

      if (index != null) {
        userProvider.users[index] = user;
      } else {
        int usersLength = userProvider.users.length;

        userProvider.users.insert(usersLength, user);
      }

    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        actions: [
          Container(
            child:Text(""),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            margin: EdgeInsets.all(8),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
             FieldForm(
                label: "Level", isPasword: false, controller: controllerlevelUser),
            FieldForm(
                label: "Name", isPasword: false, controller: controllerName),
            FieldForm(
                label: "Surname", isPasword: false, controller: controllerSurName),
            FieldForm(
                label: "Email", isPasword: false, controller: controllerEmail),
            FieldForm(
                label: "Password", isPasword: true, controller: controllerPassword),
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
