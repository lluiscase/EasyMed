import 'dart:math';
import 'package:flutterguys/pages/modules.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const CestaPage(img: '',nome: '',preco: '', state:''));

class Cesta extends StatelessWidget {
  const Cesta({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CestaPage(img: '',nome: '',preco: '',state:''),
    );
  }
}



String geradorQr(){
  var r = Random();
  String abcd = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';
  return List<String>.generate(8,(index)=>abcd[r.nextInt(10)]).join();
}



class CestaPage extends StatefulWidget {
  final String preco;
  final String img;
  final String nome;
  final String state;
  const CestaPage({super.key, required this.state,required this.img, required this.nome, required this.preco});
  @override
  State<CestaPage> createState() => CestaPageState();
}

class CestaPageState extends State<CestaPage> {
  String code = geradorQr();
  List<int> item = [];
  String total ='';
  String estado= '';
  List<String> nome = [];
  List<String> preco = [];
  List<String> imgs = [];

  Future<void> clearIndex(int index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> nomesatual = prefs.getStringList('nomes') ?? [];
    List<String> precoatual = prefs.getStringList('precos') ?? [];
    List<String> imgatual = prefs.getStringList('imagens') ?? [];

    if(index >= 0 && index < nomesatual.length){
      nomesatual.removeAt(index);
      precoatual.removeAt(index);
      imgatual.removeAt(index);

      await prefs.setStringList('nomes', nomesatual);
      await prefs.setStringList('precos', precoatual);
      await prefs.setStringList('imagens', imgatual);
    }

  }

  void calcularTotal(){
    double resultado = 0.0;
    for(int i = 0;i< preco.length;i++){
      double soma = double.tryParse(preco[i]) ?? 0.0;
      resultado +=  item[i]*soma;
    }
    total = resultado.toStringAsFixed(2);
  }



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

  Future<void> carregar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      List<String> nomesatual = prefs.getStringList('nomes') ?? [];
      List<String> precoatual = prefs.getStringList('precos') ?? [];
      List<String> imgatual = prefs.getStringList('imagens') ?? [];


      setState(() {
        nome = nomesatual;
        preco = precoatual;
        imgs = imgatual;
        item = List<int>.filled(preco.length, 1);
      });
    }catch(e){
      var pres = await prefs.clear();  await prefs.clear();
    }

  }


  @override
  void initState() {
    super.initState();
    addProduto();
    carregar();
    estado = widget.state;
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Color(0xffffffff)
        ),
        debugShowCheckedModeBanner: true,
        home: Scaffold(
          appBar: appBarReturn(context),
          body: changeScreen(),
        )
    );
  }

  Widget changeScreen(){
    final String _currentState = estado;
    if(_currentState == 'a'){
      return buildStateA();
    }else if(_currentState == 'b'){
      return buildStateB();
    }else{
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
    return Column(
      children: [
        Text('Falta pouco, Visitante...', style: TextStyle(color: Color(0xff16697a),fontSize: 20),),
        Expanded(child:
        ListView.builder(
          itemCount: nome.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 163,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 238, 238, 238),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0.3,
                            blurRadius: 1,
                            offset: Offset(0, 3)
                        )
                      ]
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,top: 10 ),
                        child: Image.network(
                            height: 125,
                            imgs[index]),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20,right: 20),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(nome[index],
                                    style:
                                    TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                Text(
                                  'R\$' + preco[index],
                                  style: TextStyle(
                                      color: Color(0xff16697A),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19),
                                ),
                              ],)
                            ,


                          ),

                          Padding(
                            padding: const EdgeInsets.only(top:45,left: 45),
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(onPressed: ()async{
                                    await clearIndex(index);
                                    setState(() {
                                      nome.removeAt(index);
                                      preco.removeAt(index);
                                      imgs.removeAt(index);
                                    });
                                    calcularTotal();
                                  }, icon: Icon(Icons.delete, color: Color(0xfffc444c),size: 20,)),
                                  SizedBox(width: 0.8),
                                  TextButton(onPressed: (){
                                    setState(() {
                                      item[index]++;
                                      calcularTotal();
                                    });
                                  },
                                      child: Text('+',
                                        style: TextStyle(fontSize: 15),)),
                                  Text(item[index].toString()),
                                  TextButton(onPressed: (){
                                    setState(() {
                                      if(item[index] == 1){
                                        item[index]=1;
                                      }else{
                                        item[index]--;
                                      }
                                      calcularTotal();
                                    });
                                  }, child: Text('-',style: TextStyle(fontSize: 15))),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                ),
              ],

            );

          },

        ),
        ),
        Text('Total: ' + total, style: TextStyle(fontSize: 18,color: Color(0xfffc444c)),),
        SizedBox(
          width: 215,
          height: 54,
          child: TextButton(
            onPressed: (){
              setState(() {
                estado = 'c';
              });
              print(estado);

            },
            child: Text('Confirmar pedido',
              style: TextStyle(
                  color: Colors.white,fontSize: 17),),
            style: TextButton.styleFrom(
              backgroundColor: Color(0xff16697a),
            ),
          ),
        ),

      ],
    );

  }

  Widget buildStateC() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Oba!', style: TextStyle(fontSize: 16,color: Color(0xff16697a)),),
        Text('Seu pedido foi confirmado pela loja', style: TextStyle(fontSize: 16,color: Color(0xff16697a))),
        Expanded(child:
        ListView.builder(
          itemCount: nome.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 163,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 238, 238, 238),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 0.3,
                            blurRadius: 1,
                            offset: Offset(0, 3)
                        )
                      ]
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,top: 10 ),
                        child: Image.network(
                            height: 125,
                            imgs[index]),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child:Expanded(child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item[index].toString() + 'x',style: TextStyle(fontSize: 14,color: Color(0xffFC444C)),),
                                Text(nome[index],
                                    style:
                                    TextStyle(fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                                Text('EasyMeds - Morumbi',style: TextStyle(fontSize: 14,color: Color(0xffFC444C)),),
                                Text('Rua das Magnólias, 222, Morumbi',style: TextStyle(fontSize: 10),)

                              ],)
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:30,left: 115),
                            child: Text(
                              'R\$' + preco[index],
                              style: TextStyle(
                                  color: Color(0xff16697A),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 19),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),

                ),
              ],

            );

          },

        ),
        ),
        Text(
          'Total da compra: R\$' + total,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.all(5),
            child: Text(
              'Lembre-se de levar um documento com foto e número de identificação para a retirada do produto.',
              style: TextStyle(fontSize: 16),),
          ),
        ),
        Container(
          margin: EdgeInsets.all(8.0),
          child: QrImageView(
            data: code,
            version: QrVersions.auto,
            size: 150.0,
          ),
        ),
        Text('Código de retirada:' + code, style: TextStyle(fontSize: 16, color: Color(0xffFC444C)),)
      ],
    );
  }
}