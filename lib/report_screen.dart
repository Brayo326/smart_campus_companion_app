import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'api_service.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final dbHelper = DBHelper();
  final apiService = ApiService();

  late Future<List<Map<String, dynamic>>> localStudents;
  late Future<List<dynamic>> apiUsers;

  @override
  void initState() {
    super.initState();
    localStudents = dbHelper.getStudents();
    apiUsers = apiService.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reports")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("Local Students", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: localStudents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!.map((s) => ListTile(title: Text(s['name']), subtitle: Text(s['course']))).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
            Divider(),
            Text("API Users", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            FutureBuilder<List<dynamic>>(
              future: apiUsers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!.map((u) => ListTile(title: Text(u['name']), subtitle: Text(u['email']))).toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}