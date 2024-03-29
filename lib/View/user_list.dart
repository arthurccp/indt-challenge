import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:indt_challenge/Model/user.dart';
import 'package:indt_challenge/View/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsersFromSharedPreferences();
  }

  Future<void> _fetchUsersFromSharedPreferences() async {
    final List<User> loadedUsers = await _loadUsersFromSharedPreferences();
    setState(() {
      users = loadedUsers;
    });
  }

  Future<List<User>> _loadUsersFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? userStrings = prefs.getStringList('users');
    if (userStrings != null) {
      return userStrings
          .map((jsonString) => User.fromJson(jsonDecode(jsonString)))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      body: ListView.builder(
        itemCount: users.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == users.length) {
            // Último item da lista, que é o botão "Voltar ao início"
            return _buildBackToStartButton(context);
          } else {
            return _buildUserListItem(context, users[index]);
          }
        },
      ),
    );
  }

  Widget _buildUserListItem(BuildContext context, User user) {
    return Container(
      child: ListTile(
        title: Text(user.name),
      ),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.4))),
    );
  }

  Widget _buildBackToStartButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            _navigateBackToStart(context);
          },
          child: Text('Voltar ao início'),
        ),
      ),
    );
  }

  void _navigateBackToStart(BuildContext context) {
    final UserProvider userProvider = UserProvider.of(context) as UserProvider;
    userProvider.indexUser = null;
    Navigator.pop(context);
  }
}
