import 'package:flutter/material.dart';
import 'package:flutterguys/pages/modules.dart';

void main() => runApp(const Historico());

class Historico extends StatefulWidget {
  const Historico({super.key});

  @override
  HistoricoState createState() => HistoricoState();
}

class HistoricoState extends State<Historico> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: appbar('a'),
        body: Center(
          child: Text(
            "Seu Historico Está vazio",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
