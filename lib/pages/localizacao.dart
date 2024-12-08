import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyMed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Historico(),
    );
  }
}

class Historico extends StatefulWidget {
  const Historico({super.key});

  @override
  HistoricoState createState() => HistoricoState();
}

class HistoricoState extends State<Historico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Encontre a EasyMeds mais próxima de você e retire sua compra, sem custos adicionais.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            Image.asset('assets/icons/localizacao.png', height: 200),

            SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Column(
                children: [
                  // Campo de CEP
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Digite o CEP",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      print("Busca realizada");
                    },
                    child: Text('BUSCAR'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.blue, // Cor do botão
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar appbar(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xffF9FAFD),
    title: const Text(
      'EasyMed',
      style: TextStyle(
        color: Color(0xff080F0F),
        fontSize: 22,
      ),
    ),
    elevation: 0.0,
    leading: GestureDetector(
      onTap: () {
        print('Logo clicado');
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF7f8f8),
          borderRadius: BorderRadius.circular(1),
        ),
        margin: const EdgeInsets.all(10),
        child: Image.asset(
          'assets/icons/logo.png',
          fit: BoxFit.contain,
          width: 50,
        ),
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          print('Clicou no carrinho');
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Image.asset(
            'assets/icons/shopping_basket.png',
            width: 50,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF7f8f8),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ),
    ],
  );
}
