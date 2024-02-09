import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indt_challenge/Model/user.dart';
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

  // Método para salvar um usuário
  Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (indexUser != null) {
      users[indexUser!] = user;
    } else {
      users.add(user);
    }

    List<String> userStrings = users.map((user) => jsonEncode(user.toJson())).toList();
    prefs.setStringList('users', userStrings);

    notifyListeners(); // Notificar os ouvintes sobre a mudança
  }

  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return users != oldWidget.users ||
           userSelected != oldWidget.userSelected ||
           indexUser != oldWidget.indexUser;
  }
}
