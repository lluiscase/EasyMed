import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

enum ScreenState { stateA, stateB, stateC }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScreenState _currentState = ScreenState.stateA;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mudança de Tela'),
      ),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Alterna entre os estados para teste
            if (_currentState == ScreenState.stateA) {
              _currentState = ScreenState.stateB;
            } else if (_currentState == ScreenState.stateB) {
              _currentState = ScreenState.stateC;
            } else {
              _currentState = ScreenState.stateA;
            }
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildContent() {
    switch (_currentState) {
      case ScreenState.stateA:
        return buildStateA();
      case ScreenState.stateB:
        return buildStateB();
      case ScreenState.stateC:
        return buildStateC();
    }
  }

  Widget buildStateA() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sua cesta está vazia...',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(35),
            child: Image.network(
              'https://via.placeholder.com/150', // Alterado para um link de exemplo
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStateB() {
    return Container(
      color: Colors.grey,
      alignment: Alignment.center,
      child: const Text(
        'Tela B',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }

  Widget buildStateC() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          color: Colors.amber,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _currentState = ScreenState.stateA;
            });
          },
          child: const Text('Voltar para A'),
        ),
      ],
    );
  }
}
