import 'package:flutter/material.dart';
import 'admin_dashboard.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final user = TextEditingController();
  final pass = TextEditingController();

  void login() {
    if (user.text == "admin" && pass.text == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminDashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Login")),
      body: Column(
        children: [
          TextField(controller: user, decoration:
           InputDecoration(labelText: "Username")),
          TextField(controller: pass, decoration: 
           InputDecoration(labelText: "Password")),
          ElevatedButton(onPressed: login, child:  Text("Login"))
        ],
      ),
    );
  }
}
