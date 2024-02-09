import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indt_challenge/Model/user.dart';
import 'package:indt_challenge/View/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdmList extends StatelessWidget {
  const AdmList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADM List"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, "/createAdm");
          },
        ),
      ),
      body: FutureBuilder<List<User>>(
        future: UserRepo.fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            final List<User>? users = snapshot.data;
            if (users == null || users.isEmpty) {
              return Center(child: Text("No users found"));
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return UserListItem(user: users[index], index: index);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                      },
                      child: Text("Voltar ao Início"),
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}

class UserListItem extends StatelessWidget {
  final User user;
  final int index;

  const UserListItem({required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = UserProvider.of(context) as UserProvider;

    return Container(
      child: ListTile(
        title: Text(user.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                userProvider.indexUser = index;
                userProvider.userSelected = user;
                Navigator.popAndPushNamed(context, "/createAdm");
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                userProvider.indexUser = index;
                userProvider.userSelected = user;
                Navigator.popAndPushNamed(context, "/view");
              },
              icon: Icon(Icons.visibility, color: Colors.blue),
            ),
            IconButton(
              onPressed: () {
                UserRepo.deleteUser(index);
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.4))),
    );
  }
}

abstract class UserRepo {
  static Future<List<User>> fetchUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userStrings = prefs.getStringList('users');
    if (userStrings == null) {
      return [];
    } else {
      List<User> users = userStrings.map((jsonString) => User.fromJson(jsonDecode(jsonString))).toList();
      return users;
    }
  }

  static Future<void> deleteUser(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userStrings = prefs.getStringList('users');
    if (userStrings != null) {
      List<User> users = userStrings.map((jsonString) => User.fromJson(jsonDecode(jsonString))).toList();
      users.removeAt(index);
      List<String> updatedUserStrings = users.map((user) => jsonEncode(user.toJson())).toList();
      await prefs.setStringList('users', updatedUserStrings);
    }
  }
}
