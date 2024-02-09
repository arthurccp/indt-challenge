import 'package:flutter/material.dart';
import 'package:indt_challenge/Model/user.dart';
import 'package:indt_challenge/View/filed_form.dart';
import 'package:indt_challenge/View/user_provider.dart';

class UserView extends StatelessWidget {
  UserView({Key? key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = UserProvider.of(context) as UserProvider;

    final User? user = userProvider.userSelected;
    final int? index = userProvider.indexUser;

    TextEditingController controllerLevelUser = TextEditingController(text: user?.level ?? '');
    TextEditingController controllerName = TextEditingController(text: user?.name ?? '');
    TextEditingController controllerSurName = TextEditingController(text: user?.surname ?? '');
    TextEditingController controllerEmail = TextEditingController(text: user?.email ?? '');
    TextEditingController controllerPassword = TextEditingController(text: user?.password ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text("Show User"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
              isForm: false,
            ),
            FieldForm(
              label: "Name",
              isPasword: false,
              controller: controllerName,
              isForm: false,
            ),
            FieldForm(
              label: "SurName",
              isPasword: false,
              controller: controllerSurName,
              isForm: false,
            ),
            FieldForm(
              label: "Email",
              isPasword: false,
              controller: controllerEmail,
              isForm: false,
            ),
            FieldForm(
              label: "Password",
              isPasword: false,
              controller: controllerPassword,
              isForm: false,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/createAdm");
                },
                child: Text("Edit"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  _deleteUser(userProvider, index);
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

  void _deleteUser(UserProvider userProvider, int? index) {
    if (index != null) {
      userProvider.indexUser = null;
      userProvider.users.removeAt(index);
    }
  }
}
