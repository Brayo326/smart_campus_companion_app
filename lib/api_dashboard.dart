import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiDashboard extends StatefulWidget {
  const ApiDashboard({super.key});

  @override
  _ApiDashboardState createState() => _ApiDashboardState();
}

class _ApiDashboardState extends State<ApiDashboard> {
  late Future<List<dynamic>> users;

  @override
  void initState() {
    super.initState();
    users = fetchUsers();
  }

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load users");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Users")),
      body: FutureBuilder<List<dynamic>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user['name']),
                  subtitle: Text(user['email']),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}