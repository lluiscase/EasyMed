import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const LocalizacaoRuas());

class LocalizacaoRuas extends StatefulWidget {
  const LocalizacaoRuas({super.key});

  @override
  LocalizacaoRuasState createState() => LocalizacaoRuasState();
}

class LocalizacaoRuasState extends State<LocalizacaoRuas> {
  String? _cepSalvo;

  @override
  void initState() {
    super.initState();
    _carregarCep();
  }

  Future<void> _carregarCep() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _cepSalvo = prefs.getString('cep');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: appbar(),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildLocationCard('EasyMeds - Morumbi', 'Rua das Magnólias, 222, Morumbi', 'CEP: $_cepSalvo', '800m'),
            _buildLocationCard('EasyMeds - Alto de Pinheiros', 'Avenida Brasil, 55, Alto de Pinheiros', 'CEP: $_cepSalvo', '1.6 km'),
            _buildLocationCard('EasyMeds - Vila Mariana', 'Avenida dos Manacás, 101, Vila Mariana', 'CEP: $_cepSalvo', '2.8 km'),
            _buildLocationCard('EasyMeds - Higienópolis', 'Rua do Pacaembu, 789, Higienópolis', 'CEP: $_cepSalvo', '950m'),
            _buildLocationCard('EasyMeds - Ibirapuera', 'Avenida Iepê Roxo, 465, Ibirapuera', 'CEP: $_cepSalvo', '2.3 km'),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard(String name, String address, String cep, String distance) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(address),
            const SizedBox(height: 4),
            Text(cep, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(distance, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
          ],
        ),
      ),
    );
  }
}

AppBar appbar() {
  return AppBar(
    backgroundColor: const Color(0xffF9FAFD),
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
