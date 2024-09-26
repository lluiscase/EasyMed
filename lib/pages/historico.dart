import 'package:flutter/material.dart';

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
        appBar: AppBar(
          backgroundColor: Colors.white, // Cor de fundo do AppBar
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/icons/logo.png',
              width: 40,
              height: 40,
            ),
          ),
          title: const Text(
            "Olá Helena",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/icons/return.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ],
          elevation: 0, // Remove a sombra
        ),
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
