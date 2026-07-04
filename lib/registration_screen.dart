import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'dashboard_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final courseController = TextEditingController();
  final dbHelper = DBHelper();

  void saveStudent() async {
    await dbHelper.insertStudent({
      "name": nameController.text,
      "course": courseController.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Student saved successfully!")),
    );
    nameController.clear();
    courseController.clear();


    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Student")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: courseController, decoration: InputDecoration(labelText: "Course")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: saveStudent, child: Text("Save Student")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/apiDashboard'),
              child: Text("View API Users"),
            ),
          ],
        ),
      ),
    );
  }
}