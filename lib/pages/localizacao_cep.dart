import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localizacao_ruas.dart';

void main() => runApp(const LocalizacaoCep());

class LocalizacaoCep extends StatelessWidget {
  const LocalizacaoCep({super.key});

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
  final TextEditingController _cepController = TextEditingController();

  Future<void> _salvarCepENavegar() async {
    final String cep = _cepController.text;
    if (cep.isEmpty || cep.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, insira um CEP válido.')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cep', cep);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocalizacaoRuas()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: SingleChildScrollView(
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
                  TextField(
                    controller: _cepController,
                    keyboardType: TextInputType.numberWithOptions(decimal: false),
                    inputFormatters: [
                      MaskedInputFormatter('#####-###'),
                    ],
                    decoration: InputDecoration(
                      labelText: "Digite o CEP",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _salvarCepENavegar,
                    child: Text('BUSCAR'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
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
