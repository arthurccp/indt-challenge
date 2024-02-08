import 'package:flutter/material.dart';
import 'package:indt_challenge/View/filed_form.dart';
import 'package:indt_challenge/View/user_provider.dart';

class UserView extends StatelessWidget {
  UserView({super.key});

  String title = "Show User";
  TextEditingController controllerLevelUser = TextEditingController();
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
      controllerLevelUser.text = userProvider.userSelected!.level;
      controllerName.text = userProvider.userSelected!.name;
      controllerSurName.text = userProvider.userSelected!.surname;
      controllerEmail.text = userProvider.userSelected!.email;
      controllerPassword.text = userProvider.userSelected!.password;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        actions: [
          Container(
            child: TextButton(
              child: Text("UserList"),
              onPressed: () {
                Navigator.popAndPushNamed(context, "/admList");
              },
            ),
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
                label: "Level",
                isPasword: false,
                controller: controllerLevelUser,
                isForm: false),
            FieldForm(
                label: "Name",
                isPasword: false,
                controller: controllerName,
                isForm: false),
            FieldForm(
                label: "SurName",
                isPasword: false,
                controller: controllerSurName,
                isForm: false),
            FieldForm(
                label: "Email",
                isPasword: false,
                controller: controllerEmail,
                isForm: false),
            FieldForm(
                label: "Password",
                isPasword: false,
                controller: controllerPassword,
                isForm: false),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/createAdm");
                },
                child: Text("Edit"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  userProvider.indexUser = null;
                  userProvider.users.removeAt(index!);
                  Navigator.popAndPushNamed(context, "/createAdm");
                },
                child: Text("delete"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
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
