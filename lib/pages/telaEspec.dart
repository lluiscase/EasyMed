import 'package:flutter/material.dart';
import 'package:flutterguys/pages/perfil.dart';
import 'package:flutterguys/pages/modules.dart';
import 'package:flutterguys/pages/produtos.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const telaEspec(categoria: '',state: '',desc: '',nome: '',prec: '',img:''));

class telaEspec extends StatefulWidget {
  final String categoria;
  final String state;
  final String desc;
  final String nome;
  final String prec;
  final String img;
  const telaEspec({super.key, required this.categoria,required this.state,required this.desc,required this.nome, required this.prec, required this.img});

  @override
  telaEspecState createState() => telaEspecState();
}
enum ScreenState { stateA, stateB}

class telaEspecState extends State<telaEspec> {
  String nome = '';
  String preco = '';
  String foto = '';
Future<void> salvamentoDados() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('${widget.nome}');
  await prefs.setString('nome', widget.nome);
  await prefs.setString('prec', widget.prec);
  await prefs.setString('img', widget.img);
  setState(() {  
  });
  loading();
}

Future<void> loading() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    print('${nome}');
    nome = prefs.getString('nome') ?? 'Nome não encontrado';
    preco = prefs.getString('prec') ?? 'Preço não encontrado';
    foto = prefs.getString('img') ?? 'Imagem não encontrado';
  });
}


@override
void initState(){
  super.initState();
  salvamentoDados();
}

  Widget changeScreen(){
  final String _currentState = widget.state;
  if(_currentState == 'A'){
    return buildStateA();
  }else{
    return buildStateB();
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: changeScreen(),
    );
  }

  Widget buildStateA() {
    return FutureBuilder(
              future: getProdutos(widget.categoria), 
              builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Erro ao carregar categorias"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Nenhuma categoria disponível"));
        }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.75
              ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Center(
                child: GestureDetector(
                  
                  onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => 
                     ProdutosPage(
                      nome: snapshot.data![index].nome,
                      desc: snapshot.data![index].descricao,
                      prec: snapshot.data![index].preco,
                      img:snapshot.data![index].foto
                        )
                      )
                    );
                  },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  width: 109,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Padding(
                        padding: const EdgeInsets.only(left: 12,top: 10),
                        child: Image.network(
                          alignment: Alignment.center, 
                            snapshot.data![index].foto, 
                            width: 75,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              return loadingProgress == null ? child : CircularProgressIndicator(); 
                            },errorBuilder:(context, url, stackTrace) {
                              return Icon(Icons.error);
                            } ,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                        snapshot.data![index].nome,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xff080F0F),
                          fontSize: 9,
                                        ),
                                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,top: 5.0),
                    child: Text(
                        'R\$${snapshot.data![index].preco}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xfffc444c),
                          fontSize: 10,
                          
                    ),
                    ),
                  ),
                    ] 
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffF9FAFD),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: Colors.grey)
                  ),
                )),
              );
              },

              );
            });
  }

  Widget buildStateB() {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.639
              ),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Center(
                child: GestureDetector(
                  
                  onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => 
                     ProdutosPage(
                      nome: widget.nome,
                      desc: widget.desc,
                      prec: widget.prec,
                      img:  widget.img
                        )
                      )
                    );
                  },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  width: 109,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Padding(
                        padding: const EdgeInsets.only(left: 12,top: 10),
                        child: Image.network(
                          alignment: Alignment.topRight, 
                          'https://raw.githubusercontent.com/lluiscase/EasyMed/refs/heads/main/assets/icons/tag.png',
                        width: 15,
                        fit: BoxFit.contain,
                        ),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12,top: 10),
                        child: Image.network(
                          alignment: Alignment.center, 
                            widget.img, 
                            width: 75,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              return loadingProgress == null ? child : CircularProgressIndicator(); 
                            },errorBuilder:(context, url, stackTrace) {
                              return Icon(Icons.error);
                            } ,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                        widget.nome,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xff080F0F),
                          fontSize: 9,
                                        ),
                                        ),
                      ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,top: 5.0),
                    child: Text(
                        'R\$${widget.prec}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xfffc444c),
                          fontSize: 10,
                          
                    ),
                    ),
                  ),
                    ] 
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffF9FAFD),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1,color: Colors.grey)
                  ),
                )),
              );
              },

              );
            }
  }