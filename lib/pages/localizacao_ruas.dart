import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterguys/pages/Cesta.dart';
import 'package:flutterguys/pages/home.dart';
import 'package:flutterguys/pages/Perfil.dart';

void main() => runApp(const LocalizacaoRuas());

class LocalizacaoRuas extends StatefulWidget {
  const LocalizacaoRuas({super.key});

  @override
  LocalizacaoRuasState createState() => LocalizacaoRuasState();
}

class LocalizacaoRuasState extends State<LocalizacaoRuas> {
  String? _cepSalvo;
  int _selectedIndex = 0;

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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Center(
                child: Text(
                  'EasyMeds próximas a você!',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      color: Colors.blue),
                ),
              ),
            ),
            _buildLocationCard('EasyMeds - Morumbi',
                'Rua das Magnólias, 222, Morumbi', 'CEP: $_cepSalvo', '800m'),
            _buildLocationCard(
                'EasyMeds - Alto de Pinheiros',
                'Avenida Brasil, 55, Alto de Pinheiros',
                'CEP: $_cepSalvo',
                '1.6 km'),
            _buildLocationCard(
                'EasyMeds - Vila Mariana',
                'Avenida dos Manacás, 101, Vila Mariana',
                'CEP: $_cepSalvo',
                '2.8 km'),
            _buildLocationCard(
                'EasyMeds - Higienópolis',
                'Rua do Pacaembu, 789, Higienópolis',
                'CEP: $_cepSalvo',
                '950m'),
            _buildLocationCard(
                'EasyMeds - Ibirapuera',
                'Avenida Iepê Roxo, 465, Ibirapuera',
                'CEP: $_cepSalvo',
                '2.3 km'),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(180, 51),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Cesta(),
                    ));
              },
              child: const Text(
                'Ir para seu comprovante ',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: bottomNav(_selectedIndex, (index) {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
              break;
            case 1:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cesta()));
              break;
            case 2:
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Perfil()));
              break;
            default:
              break;
          }
        }),
      ),
    );
  }

  Widget _buildLocationCard(
      String name, String address, String cep, String distance) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Montserrat',
                  color: Color(0xFFFC444C),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                address,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'NunitoSans',
                    color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(cep,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'NunitoSans',
                  )),
              const SizedBox(height: 8),
              Text(distance,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15,
                      fontFamily: 'NunitoSans',
                      color: Color(0xFF16697A))),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNav(int selectedIndex, ValueChanged<int> onTap) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          label: 'Cesta',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    );
  }
}

AppBar appbar() {
  return AppBar(
    backgroundColor: const Color(0xffF9FAFD),
    title: const Text(
      'EasyMed',
      style: TextStyle(
          color: Color(0xff080F0F), fontSize: 22, fontFamily: 'Poppins'),
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
