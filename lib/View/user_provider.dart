import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indt_challenge/Model/user.dart';
import 'package:indt_challenge/View/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends InheritedWidget with ChangeNotifier {
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

  // Método para atualizar a lista de usuários
  void updateUsers(List<User> newUsers) {
    users.clear();
    users.addAll(newUsers);
    notifyListeners(); // Notificar os ouvintes sobre a mudança
  }

  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return users != oldWidget.users ||
           userSelected != oldWidget.userSelected ||
           indexUser != oldWidget.indexUser;
  }
}
