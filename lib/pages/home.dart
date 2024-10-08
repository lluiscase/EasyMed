import 'package:flutter/material.dart';
import 'package:flutterguys/pages/perfil.dart';
import 'package:flutterguys/pages/modules.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

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

class HomePageState extends State<HomePage> {
  late Future<List<Categoria>> categoriaProdutos;
  @override
  void initState(){
    super.initState();
    categoriaProdutos = fetchCategorias();
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

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffF9FAFD),
        appBar: appbar(),
        bottomNavigationBar: Builder(
          builder: (BuildContext context) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Color(0xff16697A),
              backgroundColor: Color(0xffF9FAFD),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled, color: Color(0xff16697A),),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on, color: Color(0xff16697A)),
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
            );
          }
        ),
        body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchField(),
              TitleProduct('Categorias'),
              Container(
              height: 100,
              child: FutureBuilder(
                future: fetchCategorias(), 
                builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar categorias"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhuma categoria disponível"));
          }
            return ListView.separated(
                      
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  width: 100,
                  height: 5,
                  child: Column(
                    children:[
                      Image.network(
                        snapshot.data![index].photo, 
                        width: 27,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          return loadingProgress == null ? child : CircularProgressIndicator(); 
                        },errorBuilder:(context, url, stackTrace) {
                          return Icon(Icons.error);
                        } ,),
                      Text(
                      snapshot.data![index].nome,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff16697A),
                        fontSize: 15,
                  ),
                  ),

                    ] 
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffeeefe6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              }),
            ),
              TitleProduct('Festival do bebê'),
              Container(
                height: 150,
                child: BuilderCards('Higiene bebe'),
              ),
              TitleProduct('Beleza'),
              Container(
                height: 150,
                child: BuilderCards('Beleza'),
              ),
              TitleProduct('Higiene'),
              Container(
                height: 150,
                child: BuilderCards('Higiene'),
              ),
              TitleProduct('Medicamentos'),
              Container(
                height: 150,
                child: BuilderCards(''),
              ),
            ],
          )
        )
      ),
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
            itemCount: snapshot.data!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                width: 95,
                height: 5,
                child: Column(
                  children:[
                    Image.network(
                        snapshot.data![index].foto, 
                        width: 65,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          return loadingProgress == null ? child : CircularProgressIndicator(); 
                        },errorBuilder:(context, url, stackTrace) {
                          return Icon(Icons.error);
                        } ,),
                    Text(
                    snapshot.data![index].nome,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xff080F0F),
                      fontSize: 9,
                      
                ),
                ),
                Text(
                    'R\$${snapshot.data![index].preco}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xfffc444c),
                      fontSize: 12,
                ),
                ),
                  ] 
                ),
                decoration: BoxDecoration(
                  color: Color(0xffF9FAFD),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1,color: Colors.grey)
                ),
              );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            });
  }

}
