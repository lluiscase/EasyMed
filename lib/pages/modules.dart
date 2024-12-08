// modules_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutterguys/pages/produtos.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterguys/pages/Cesta.dart';
List<String> allProdutosList = [];



class Produtos {
  final String id;
  final String nome;
  final String preco;
  final String descricao;
  final String foto;

  Produtos({required this.id, required this.nome, required this.preco, required this.descricao, required this.foto});

  factory Produtos.fromJson(Map<String, dynamic> json) {
    return Produtos(
      id: json['id'],
      nome: json['nome'],
      preco: json['preco'],
      descricao: json['descricao'] ?? '',
      foto: json['foto']?? ''
    );
  }
}

class Categoria {
  final String nome;
  List<Produtos> produtos;
  final String photo;

  Categoria({required this.nome, required this.produtos, required this.photo});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    var produtoList = json['produtos'] as List?;
    List<Produtos> produtos = produtoList?.map((produtoJson) => Produtos.fromJson(produtoJson)).toList() ?? [];
    return Categoria(
      nome: json['nome'],
      produtos: produtos,
      photo: json['photo']?? ''
    );
  }
}

Future<List<Categoria>> fetchCategorias() async {
  final response = await http.get(Uri.parse('https://raw.githubusercontent.com/lluiscase/EasyMed/refs/heads/main/produtos.json'));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.body);
    List<dynamic> categoriasJson = jsonData['categoria'];
    return categoriasJson.map((categoriaJson) => Categoria.fromJson(categoriaJson)).toList();
  } else {
    throw Exception('Falha de carregamento');
  }
}


Future<List<Produtos>> getProdutos(String nomecategoria)async{
  var categoria = await fetchCategorias();
  var vereficador = categoria.where((categoria)=>categoria.nome == nomecategoria );
  List<Produtos> produtosList = [];
  for(var b in vereficador){
     produtosList.addAll(b.produtos);
  }
  return produtosList;
}

Future<void> getallProdutos(List<String> h)async{
  var categoria = await fetchCategorias();
  h.clear();
  for(var b in categoria){
     h.addAll(b.produtos.map((produto) => 
     produto.nome.toString()));
  }
}
// AppBar
AppBar appbar(String estado) {
  return AppBar(
    backgroundColor: Color(0xffF9FAFD),
    title: Text(
      'Olá Visitante',
      style: TextStyle(
        color: const Color(0xff080F0F),
        fontSize: 22,
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
        child: Image.asset(
          'assets/icons/logo.png',
          fit: BoxFit.contain,
          width: 50,
        ),
      ),
    ),
    actions: [
        Builder(
          builder: (context) {
            return Container(
              margin: EdgeInsets.all(10),
              child: IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CestaPage(img: '',nome: '',preco: '',state:estado)));
                },
                icon:Image.asset(
                'assets/icons/shopping_basket.png',
                height:25,
              )),
              decoration: BoxDecoration(
                color: Color(0xffF7f8f8),
                borderRadius: BorderRadius.circular(1),
              ),
            );
          }
        ),
    ],
  );
}

// Search Field
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

// Title Product
Padding titleProduct(String titulo, String plus) {
  return Padding(
    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          titulo,
          style: TextStyle(
            color: Color(0xff16697A),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          child: Text(
            plus,
            style: TextStyle(
              color: Color(0xfffc444c),
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// Bottom Navigation Bar
BottomNavigationBar bottomNav(int _selectedIndex, Function(int) onTap) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xff16697A),
    backgroundColor: Color(0xffF9FAFD),
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home_filled, color: Color(0xff16697A)),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.location_on, color: Color(0xff16697A)),
        label: 'Localização',
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
    onTap: onTap,
  );
}


FutureBuilder<List<Produtos>> BuilderCards(String fetchget) {
    return FutureBuilder(
              future: getProdutos(fetchget), 
              builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Erro ao carregar categorias"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Nenhuma categoria disponível"));
        }
          return ListView.separated(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
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
                separatorBuilder: (context, index) => const Divider(),
              );
            });
  }