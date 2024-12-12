import 'package:flutter/material.dart';
import 'package:flutterguys/pages/perfil/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(nomeUsuario: ''),
    );
  }
}

