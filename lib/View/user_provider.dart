import 'package:flutter/material.dart';
import 'package:indt_challenge/Model/user.dart';

class UserProvider extends InheritedWidget {
  final Widget child;
  List<User> users = [];
  User? userSelected;
  int? indexUser;

  UserProvider({
    required this.child,
  }) : super(child: child);

  static UserProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  bool updateShouldNotify(UserProvider widget) {
    return true;
  }

  // Método para atualizar a lista de usuários
  void setUsers(List<User> newUsers) {
    users.clear();
    users.addAll(newUsers);
  }
}
