import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartcanteen/provider/menu_provider.dart';
import 'package:smartcanteen/provider/order_provider.dart';
import 'package:smartcanteen/screens/register.dart';
import 'package:smartcanteen/screens/userlogin.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: const SmartCanteenApp(),
    ),
  );
}

class SmartCanteenApp extends StatelessWidget {
  const SmartCanteenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Canteen',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home:  RegisterPage()
    );
  }
}
