import 'package:flutter/material.dart';
import 'package:indt_challenge/View/adm_form.dart';
import 'package:indt_challenge/View/user_form.dart';
import 'package:indt_challenge/View/adm_list.dart';
import 'package:indt_challenge/View/user_list.dart';
import 'package:indt_challenge/View/user_login.dart';
import 'package:indt_challenge/View/user_provider.dart';
import 'package:indt_challenge/View/user_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return UserProvider(
      child: MaterialApp(
        title: 'CRUD_APP',
        home: UserLogin(),
        routes: {
          "/createAdm": (_) => const AdmForm(),
          "/createUser": (_) => const UserForm(),
          "/admList": (_) => const AdmList(),
          "/userList": (_) => const UserList(), 
          "/view": (_) => UserView(),
          "/login": (_) => const UserLogin(),
        },
      ),
    );
  }
}
