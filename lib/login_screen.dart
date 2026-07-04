import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                  Navigator.pushReplacementNamed(context, '/registration');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter credentials")));
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}