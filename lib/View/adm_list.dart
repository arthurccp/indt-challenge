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
        future: _fetchUsersFromSharedPreferences(),
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
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildUserListItem(context, users[index], index);
                },
              );
            }
          }
        },
      ),
    );
  }

  Widget _buildUserListItem(BuildContext context, User user, int index) {
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
                _deleteUser(index);
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.4))),
    );
  }

  Future<List<User>> _fetchUsersFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userStrings = prefs.getStringList('users');
    if (userStrings == null) {
      return [];
    } else {
      List<User> users = userStrings
          .map((jsonString) => User.fromJson(jsonDecode(jsonString)))
          .toList();
      return users;
    }
  }

  Future<void> _deleteUser(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userStrings = prefs.getStringList('users');
    if (userStrings != null) {
      List<User> users = userStrings
          .map((jsonString) => User.fromJson(jsonDecode(jsonString)))
          .toList();
      users.removeAt(index);
      List<String> updatedUserStrings =
          users.map((user) => jsonEncode(user.toJson())).toList();
      await prefs.setStringList('users', updatedUserStrings);
    }
  }
}
