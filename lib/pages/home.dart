import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FAFD),
      appBar: AppBar(
        backgroundColor: Color(0xffF9FAFD),
        title: Text(
          'EasyMed',
          style: TextStyle(
            color: const Color(0xff080F0F),
            fontSize: 25,
            fontWeight: FontWeight.w700
                      ),
        ),
        elevation: 0.0,
        leading: GestureDetector(
          onTap: (){
            print('Caracas ele clicou em mim');
          },
            child: Container(
            margin: EdgeInsets.all(10),
            child: Image.asset(
              'assets/icons/Captura de tela 2024-09-14 150339.png'
            ),
            decoration: BoxDecoration(
              color: Color(0xffF7f8f8 ),
              borderRadius: BorderRadius.circular(1)
            ),
          ),
        ),

        actions: [
          GestureDetector(
            onTap: (){

            },
            child:Container(
            margin: EdgeInsets.all(10),
            child: Image.asset(
            'assets/icons/Captura de tela 2024-09-14 151553.png'
            ),
            decoration: BoxDecoration(
            color: Color(0xffF7f8f8 ),
            borderRadius: BorderRadius.circular(1)
          ),
        ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_searching),
            label: 'Localização'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_busy),
            label: 'ofertas'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'perfil'
          ),
        
        ],
          currentIndex: 0
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          searchField(),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 20),
            child: Column(
              children: [
                Text(
                  'Categoria',
                  style: TextStyle(
                    color: Color(0xff16697A),
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 150,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }

  Container searchField() {
    return Container(
          margin: EdgeInsets.only(top: 40,left: 20, right: 20),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff101617).withOpacity(0.11),
                blurRadius: 40,
                spreadRadius: 0.0
              )
            ]
          ),
          height: 35,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 226, 226, 226),
              hintText: 'Pesquisar um item',
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 190, 190, 190),
                fontSize: 12
              ),
              prefixIcon:Icon(Icons.search) ,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
              )
            ),
          ),
        );
  }
}