import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cupons',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TelaCupons(),
    );
  }
}

class Cupom {
  final String titulo;
  final String botao;
  final String detalhes;

  Cupom({
    required this.titulo,
    required this.botao,
    required this.detalhes,
  });
}

class TelaCupons extends StatefulWidget {
  const TelaCupons({super.key});

  @override
  State<TelaCupons> createState() => _TelaCuponsState();
}

class _TelaCuponsState extends State<TelaCupons> {
  String nomeUsuario = 'Visitante';

  static final List<Cupom> cupons = [
    Cupom(
      titulo: '20% OFF em produtos de beleza, acima de R\$90,00',
      botao: 'Resgatar',
      detalhes: 'Válido até 03/11/2024',
    ),
    Cupom(
      titulo: '50% OFF na sua primeira compra',
      botao: 'Resgatar',
      detalhes: 'Válido até 31/12/2024',
    ),
    Cupom(
      titulo: 'Ganhe 10% OFF em cuidados pessoais e vitaminas',
      botao: 'Resgatar',
      detalhes: 'Válido até 01/12/2024',
    ),
    Cupom(
      titulo: 'Ganhe 50% OFF em produtos Wella',
      botao: 'Expirado',
      detalhes: 'Válido até 12/11/2024',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _carregaNomeUsuario();
  }

  Future<void> _carregaNomeUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuario = prefs.getString('nomeUsuario') ?? 'Visitante';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, $nomeUsuario!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cupons.length,
        itemBuilder: (context, index) {
          final cupom = cupons[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cupom.titulo,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(cupom.detalhes),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: cupom.botao == 'Expirado'
                        ? null
                        : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${cupom.titulo} resgatado!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      cupom.botao == 'Expirado' ? Colors.grey : Colors.blue,
                    ),
                    child: Text(cupom.botao),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
