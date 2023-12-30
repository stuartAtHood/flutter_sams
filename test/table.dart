import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);
}

class MyApp extends StatelessWidget {
  final List<User> users = [
    User('John Doe', 'johndoe@example.com'),
    User('Jane Smith', 'janesmith@example.com'),
    User('Bob Johnson', 'bob@example.com'),
    User('Alice Brown', 'alice@example.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Table Example'),
        ),
        body: Center(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Email')),
            ],
            rows: users.map((user) {
              return DataRow(
                cells: [
                  DataCell(Text(user.name)),
                  DataCell(Text(user.email)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
