import 'package:flutter/material.dart';
import 'db_helper.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student Records")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/apiDashboard'),
              child: Text("Fetch Remote API Users"),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: dbHelper.getStudents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("No students found"));
                } else {
                  final students = snapshot.data!;
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(students[index]['name']),
                        subtitle: Text(students[index]['course']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await dbHelper.deleteStudent(students[index]['id']);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Student deleted")),
                            );
                            setState(() {}); // refresh list
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}