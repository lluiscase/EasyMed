import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterguys/pages/home.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const CestaPage(img: '',nome: '',preco: ''));

class Cesta extends StatelessWidget {
  const Cesta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CestaPage(img: '',nome: '',preco: ''),
    );
  }
}



String geradorQr(){
  var r = Random();
  String abcd = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';
  return List<String>.generate(5,(index)=>abcd[r.nextInt(10)]).join();
}

enum ScreenState { stateA, stateB, stateC }

class CestaPage extends StatefulWidget {
  final String preco;
  final String img;
  final String nome;
  const CestaPage({super.key, required this.img, required this.nome, required this.preco});
  @override
  State<CestaPage> createState() => CestaPageState();
}

class CestaPageState extends State<CestaPage> {
  ScreenState _currentState = ScreenState.stateB;
  String code = geradorQr();
  int item = 1;
  String total ='';

  void calcularTotal(){
  double e = double.parse(widget.preco);
  double resultado = item *e;
  total = resultado.toString();
}

  List<String> nome = [];
  List<String> preco = [];
  List<String> imgs = [];


  Future<void> addProduto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> nomesatual = prefs.getStringList('nomes') ?? [];
    List<String> precoatual = prefs.getStringList('precos') ?? [];
    List<String> imgatual = prefs.getStringList('imagens') ?? [];

    String nome = widget.nome;
    String preco = widget.preco;
    String img = widget.img;

    if (!nomesatual.contains(nome)) {
      nomesatual.add(nome);
      precoatual.add(preco);
      imgatual.add(img);
    }


    await prefs.setStringList('nomes', nomesatual);
    await prefs.setStringList('precos', precoatual);
    await prefs.setStringList('imagens', imgatual);


    setState(() {
      this.nome = nomesatual;
      this.preco = precoatual;
      this.imgs = imgatual;
    });
  }


  Future<void> verItens() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> nomesatual = prefs.getStringList('nomes') ?? [];
    List<String> precoatual = prefs.getStringList('precos') ?? [];
    List<String> imgatual = prefs.getStringList('imagens') ?? [];

    setState(() {
      nome = nomesatual;
      preco = precoatual;
      imgs = imgatual;
    });
  }

  @override
  void initState() {
    super.initState();
    addProduto();
    verItens();
  }

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.network(
          'https://raw.githubusercontent.com/lluiscase/EasyMed/refs/heads/main/assets/icons/logo_easyMeds.png',
          fit: BoxFit.contain,
          height: 68,
          ),
          actions:[
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                }, 
                icon: Icon(
                Icons.keyboard_return, 
                color: Colors.red,
                ),
                iconSize: 39,
                ),
            )
            
          ] 
      ),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Alterna entre os estados para teste
            if (_currentState == ScreenState.stateA) {
              _currentState = ScreenState.stateB;
            } else if (_currentState == ScreenState.stateB) {
              _currentState = ScreenState.stateC;
            } else {
              _currentState = ScreenState.stateA;
            }
          });
        },
        child: const Icon(Icons.refresh),
      ),
    )
    ); 
  }

  Widget _buildContent() {
    switch (_currentState) {
      case ScreenState.stateA:
        return buildStateA();
      case ScreenState.stateB:
        return buildStateB();
      case ScreenState.stateC:
        return buildStateC();
    }
  }

  Widget buildStateA() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sua cesta está vazia...',
            style: TextStyle(
              fontSize: 24,
            ),
          ), 
          Image.network(
              'https://s3-alpha-sig.figma.com/img/44b1/9eae/018d5ac0085149065678b2ad96513192?Expires=1734307200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=knEq75CtSLQfcUCR4QqXn0GTb0tVBUqwr8cpKLmeWzS-60G~BVg46VOWih0RZkM6kHwKghQ0Lj-Kb0OGwHRDU9fMp5aKkQj6oi7JoOcKFR37hmUK8NN7j0d64ivsghEO68cu7liEQ5CwiFVpjWFK5F8zuJiWReVafszX2R92BAToMSfbMNoPp0O2wW9zOuel-6fPBPGxAiGCnn1~cS2-JU5VZOOq2Rmgsdx49cFQ4xYLc6D4Q0hzFNzVd0lmrZro5p6jpplmOl0nLxG7uod23M-~MWBY2GwuXlLMiWFZONys3BiBQAlKTw1dg1glJIERFZHo2JfwLjzySGJkA8629g__',
              
            ),
        ],
      ),
    );
  }

  Widget buildStateB() {
    return ListView.builder(
      itemCount: nome.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
        Text('Falta pouco, Visitante...'),
        Container(
          height: 163,
          color: Color(0xffD9D9D9),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.network(
                    height: 125,
                    imgs[index]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 25.0),
                child: Column(
                  children: [
                    Text(nome[index],
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                    Text(
                      'R\$' + preco[index],
                      style: TextStyle(
                          color: Color(0xff16697A),
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ),
                    Container(
                      color: Colors.white,
                      height: 35,
                      child: Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.badge)),
                          TextButton(onPressed: (){
                            setState(() {
                              item++;
                              calcularTotal();
                            });
                          }, 
                          child: Text('+', 
                          style: TextStyle(fontSize: 15),)),
                          Text(item.toString()),
                          TextButton(onPressed: (){
                            setState(() {
                              if(item == 1){
                                item = 1;
                              }else{
                                item--;
                              }
                              calcularTotal();
                            });
                          }, child: Text('-',style: TextStyle(fontSize: 15))),
                          
                        ],
                      ),
                    ),
                    Text('Total: ' + total)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 65,
          height: 54,
          child: TextButton(
            onPressed: (){}, 
            child: Text('Confirmar pedido', 
            style: TextStyle(
              color: Colors.white),),
            style: TextButton.styleFrom(
              backgroundColor: Color(0xff16697a),
            ),
            ),
        )
      ],
        );
      },
      
    );
  }

  Widget buildStateC() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Oba!'),
        Text('Seu pedido foi confirmado pela loja'),
        Image.network(
                  height: 125,
                  widget.img),
              Column(
                children: [
                  Text(widget.nome,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  Text(
                    'R\$' + widget.preco,
                    style: TextStyle(
                        color: Color(0xff16697A),
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  )
                ],
              ),
              Text(
                'Lembre-se de levar um documento com foto e número de identificação para a retirada do produto.'),
              QrImageView(
                data: code,
                version: QrVersions.auto,
                size: 150.0,
              ),
      ],
    );
  }
}
