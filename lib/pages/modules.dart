import 'package:flutter/material.dart';
/*import 'package:flutterguys/pages/home.dart';
import 'package:flutterguys/pages/perfil.dart';*/

AppBar appbar() {
    return AppBar(
        backgroundColor: Color(0xffF9FAFD),
        title: Text(
          'Olá Helena',
          style: TextStyle(
            color: const Color(0xff080F0F),
            fontSize: 22
          ),
        ),
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            print('teste');
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffF7f8f8),
              borderRadius: BorderRadius.circular(1),
            ),
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Flexible(
                  child: Image.asset(
                    'assets/icons/logo.png',
                    fit: BoxFit.contain,
                    width: 50,
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

    Padding TitleProduct(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20,right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo, 
            style: TextStyle(
              color: Color(0xff16697A),
                fontSize: 14,
                fontWeight: FontWeight.w600,
          ),),
          Text(
            'Ver mais', 
            style: TextStyle(
              color: Color(0xfffc444c),
                fontSize: 14,
                fontWeight: FontWeight.w600,
          ),)
        ],
      ),
    );
  }