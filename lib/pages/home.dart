import 'package:flutter/material.dart';
import 'package:flutterguys/pages/perfil.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffF9FAFD),
        appBar: AppBar(
          backgroundColor: Color(0xffF9FAFD),
          title: Text(
            'Olá Helena',
            style: TextStyle(
              color: const Color(0xff080F0F),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () {
              print('Caracas ele clicou em mim');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffF7f8f8),
                borderRadius: BorderRadius.circular(1),
              ),
              margin: EdgeInsets.all(8),
              child: Row(
                children: [
                  Flexible(
                    child: Image.asset(
                      'assets/icons/logo.png',
                      fit: BoxFit.contain,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                print('Clicou no carrinho');
              },
              child: Container(
                margin: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/icons/shopping_basket.png',
                  width: 50,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffF7f8f8),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff16697A),
          backgroundColor: Color(0xffF9FAFD),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/medicamento.png'),
                color: Color(0xff16697A),
              ),
              label: 'Localização',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/tag.png'),
                color: Color(0xff16697A),
              ),
              label: 'Ofertas',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/profile_user.png'),
                color: Color(0xff16697A),
              ),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            if (index == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Perfil()));
            }
            else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Perfil()),
              );
            }
            else if (index == 3) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Perfil()));
            }
            else Navigator.push(context, MaterialPageRoute(builder: (context) => Perfil()));
            },
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchField(),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                'Categoria',
                style: TextStyle(
                  color: Color(0xff16697A),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: 150,
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }

  Container searchField() {
    return Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff101617).withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      height: 35,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 226, 226, 226),
          hintText: 'Pesquisar um item',
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 190, 190, 190),
            fontSize: 12,
          ),
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
