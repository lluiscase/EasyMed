import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localizacao_ruas.dart';
import 'package:flutterguys/pages/home.dart';
import 'package:flutterguys/pages/perfil.dart';

void main() => runApp(const LocalizacaoCepApp());

class LocalizacaoCepApp extends StatelessWidget {
  const LocalizacaoCepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyMed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Montserrat',
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 22,
            color: Color(0xff080F0F),
          ),
        ),
      ),
      home: const LocalizacaoCep(),
    );
  }
}

class LocalizacaoCep extends StatefulWidget {
  const LocalizacaoCep({super.key});

  @override
  LocalizacaoCepState createState() => LocalizacaoCepState();
}

class LocalizacaoCepState extends State<LocalizacaoCep> {
  final TextEditingController _cepController = TextEditingController();
  int _selectedIndex = 1;

  Future<void> _salvarCepENavegar() async {
    final String cep = _cepController.text.trim();
    if (cep.isEmpty || cep.length < 9) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira um CEP válido.')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cep', cep);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LocalizacaoRuas()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const Text(
              "Encontre a EasyMed mais próxima de você e retire sua compra, sem custos adicionais.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            Image.asset('assets/imagens/localizacao.png', height: 200),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Column(
                children: [
                  Text(
                    'Encontre unidades próximas',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 19,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _cepController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [MaskedInputFormatter('#####-###')],
                    decoration: const InputDecoration(
                      labelText: "Digite o CEP",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _salvarCepENavegar,
                    child: const Text(
                      'BUSCAR',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: bottomNav(_selectedIndex, (index) {
        setState(() {
          _selectedIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LocalizacaoRuas()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Perfil()),
            );
            break;
          default:
            break;
        }
      }),
    );
  }

  Widget bottomNav(int selectedIndex, Function(int) onTap) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Localização',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0xffF9FAFD),
    title: const Text(
      'EasyMed',
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xff080F0F),
      ),
    ),
    elevation: 0.0,
    leading: GestureDetector(
      onTap: () {
        print('Logo clicado');
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Image.asset(
          'assets/icons/logo.png',
          fit: BoxFit.contain,
          width: 50,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffF7F8F8),
          borderRadius: BorderRadius.circular(4),
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
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    ],
  );
}
