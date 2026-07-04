import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'dashboard_screen.dart';
import 'api_dashboard.dart';
import 'report_screen.dart';

void main (){
  runApp(StudentRecordApp());
}
class StudentRecordApp extends StatelessWidget {
  const StudentRecordApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Smart Campus Companion',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
      routes: {
        '/registration': (context) => RegistrationScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/apiDashboard': (context) => ApiDashboard(),
        '/reports': (context) => ReportScreen(),
      },
    );
  }
}