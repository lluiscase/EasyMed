import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterguys/pages/home.dart';
import 'package:flutterguys/pages/perfil.dart';
import 'package:flutterguys/pages/modules.dart';
import 'package:flutterguys/pages/telaEspec.dart';
import 'package:flutter/services.dart';
import 'package:flutterguys/pages/Cesta.dart';

  void main() => runApp(const ProdutosPage(desc: '',nome: '',prec: '',img:''));

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key, required this.desc,required this.nome, required this.prec, required this.img});
  
  final String desc;
  final String nome;
  final String prec;
  final String img;

  @override
  ProdutosPageState createState() => ProdutosPageState();
}

class ProdutosPageState extends State<ProdutosPage>{
  String url = 'https://raw.githubusercontent.com/lluiscase/EasyMed/refs/heads/main/assets/icons/coracao.png';
  int _selectedIndex = 0;
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.desc.isEmpty){
      print('O codigo não pode ser iniciado pela tela produtos :D');
      exit(0);
    }
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        backgroundColor: Color(0xffF9FAFD),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(122), 
          child: Column(
            children: [
              AppBar(
                title: Image.network(
                  'https://raw.githubusercontent.com/lluiscase/EasyMed/refs/heads/main/assets/icons/logo_easyMeds.png',
                  width: 165
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
              Container(
                child: Row(
                  children: [
                    TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(state: '',)));
                  }, 
                  child: Text(
                    '<',
                    style: TextStyle(
                      fontSize: 35
                    ),
                  )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Text(
                      'Detalhes do produto',
                      textAlign: TextAlign.center,
                    style: TextStyle(
                      
                      fontSize: 17,
                      color: Color(0xff16697A)
                    ),
                    ),
                  ),
                  
                  Divider(
                    color: Colors.grey[300],
                    thickness: 2,
              ),
                  ],
                ),
              ), 
                
            ],
          )
          ),
          bottomNavigationBar: bottomNav(_selectedIndex, (index){
           setState(() {
          _selectedIndex = index;
        });
        switch (index) {
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(state: '',)));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Perfil()));
            break;
          default:
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(state: '',)));
        }
        }),
        body:Expanded( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
        Container(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: (){
                  setState(() {
                    url = 'https://raw.githubusercontent.com/lluiscase/EasyMed/refs/heads/main/assets/icons/heart.png';
                  });
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>
                    telaEspec(
                      categoria: '', 
                      state: 'Favoritos', 
                      desc: widget.desc, 
                      nome: widget.nome, 
                      prec: widget.prec, 
                      img: widget.img)));
                }, 
                
              icon: Image.network(
                url,
                  width: 34,
              )
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Center(
                  child: Image.network(widget.img, width: 150,)
                  ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 25.0),
                child: Align(
                  alignment:Alignment.centerLeft, 
                  child:Text(widget.nome,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  ),
                  )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 25.0),
                child: Align(alignment:Alignment.centerLeft, 
                child:Text('R\$'+ widget.prec,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 17,
                  color: Color(0xffFC444C),
                  fontWeight: FontWeight.w700
                ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(35),
                child: Center(
                  child: 
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CestaPage(img: widget.img,nome: widget.nome, preco: widget.prec,state: 'b',)));
                      }, 
                      child: Text(
                        'Adicionar à cesta',
                      style: TextStyle(
                        color: Color(0xffFFFFFF)
                      ),),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40,vertical: 15)),
                        backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff16697A)),
                        
                      ),
                      ),
                ),
              ),
               Divider(
                    color: Colors.grey[300],
                    thickness: 2,
              ),

            ],
            ),
        ),


        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Descrição',style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.desc,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400
                ),
                ),
            ),
            
          ],
          ),
        )

          ],
        ),
      )),
    );
}
}