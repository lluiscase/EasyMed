import 'package:flutter/material.dart';
import 'package:flutterguys/pages/perfil.dart';
import 'package:flutterguys/pages/modules.dart';
import 'package:flutterguys/pages/produtos.dart';
import 'package:flutterguys/pages/telaEspec.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final SearchController controller = SearchController();
  final TextEditingController textController = TextEditingController();

  List<String> allProdutosList = [];
  String searchResult = '';
  int _selectedIndex = 0;
  @override
  void initState(){
    super.initState();
    getallProdutos(allProdutosList);
  }

  void _filterItems(String query) {
  setState(() {
    searchResult = allProdutosList.firstWhere((item) => item.toLowerCase().contains(query.toLowerCase()));
  });
}
  @override
  void dispose() {
    controller.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffF9FAFD),
        appBar: appbar(),
        bottomNavigationBar: bottomNav(_selectedIndex, (index){
           setState(() {
          _selectedIndex = index;
        });
        switch (index) {
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Perfil()));
            break;
          default:
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
        }),
        body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                    SearchAnchor(
                viewHintText: 'Pesquise...',
                searchController: controller,
                builder: (context,controller){
                  return Container(
                    margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff101617).withOpacity(0.11),
                          blurRadius: 40,
                          spreadRadius: 0.0,
                        )
                      ]
                    ),
                    height: 35,
                    child: TextField(
                      controller: textController,
                      onChanged: _filterItems,
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
                    onTap: (){
                      controller.openView();
                    },
                    ),
                      
                  );
                },
                suggestionsBuilder: (context, controller) {
                  return  List<ListTile>.generate(allProdutosList.length,(index){
                      String text = '';
                    setState(() {

                      text = allProdutosList[index];
                    });
                    return ListTile(
                      title: Text(text),
                    );
                  });
                },
              ),
                   
              titleProduct('Ofertas', ''),
              Container(
                height: 164,
                child: FutureBuilder(
                  future: fetchCategorias(), 
                  builder: (context,snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar categorias"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhuma categoria disponível"));
          }
            return  ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context,index){
                return GestureDetector(
              onTap: (){
                //var cash = double.parse(snapshot.data![index].produtos[index].preco);
                //var ofert = cash - 10;
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProdutosPage(
                  desc: snapshot.data![index].produtos[index].descricao, 
                  nome: snapshot.data![index].produtos[index].nome, 
                  prec: snapshot.data![index].produtos[index].preco, 
                  img: snapshot.data![index].produtos[index].foto)));
              },
              child:Container(
                  margin: EdgeInsets.all(8.0),
                  width: 95,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          snapshot.data![index].produtos[index].foto, 
                          height: 65,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            return loadingProgress == null ? child : CircularProgressIndicator(); 
                          },errorBuilder:(context, url, stackTrace) {
                            return Icon(Icons.error);
                          } ,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                      snapshot.data![index].produtos[index].nome,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xff080F0F),
                        fontSize: 9,
                                      ),
                                      ),
                    ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                      'R\$${snapshot.data![index].produtos[index].preco}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xfffc444c),
                        fontSize: 10,
                        
                  ),
                  ),
                ),
                    ],
                  ),
                  decoration: BoxDecoration(
                  color: Color(0xffF9FAFD),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1,color: Colors.grey)
                ),
                ));
              }, 
              separatorBuilder:  (context, index) => const Divider(), 
              );
                  }
                  ),
              ),
              //
              titleProduct('Categorias', ''),
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
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>telaEspec(
                      categoria: snapshot.data![index].nome,state: 'A',nome: '',prec: '',desc: '',img: '',
                  )));
                  },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 100,
                  height: 5,
                  child: Column(
                    children:[
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Image.network(
                          snapshot.data![index].photo, 
                          width: 35,
                          fit: BoxFit.contain,
                          color: Color(0xff16697A),
                          loadingBuilder: (context, child, loadingProgress) {
                            return loadingProgress == null ? child : CircularProgressIndicator(); 
                          },errorBuilder:(context, url, stackTrace) {
                            return Icon(Icons.error);
                          } ,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.5),
                        child: Text(
                        snapshot.data![index].nome,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff16697A),
                          fontSize: 12,
                                          ),
                                          ),
                      ),
                    ] 
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffeeefe6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
                );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              }),
            ),
              GestureDetector(
                child:titleProduct('Festival do bebê', 'Ver mais'), 
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>telaEspec(
                      categoria: 'Higiene bebe',state: 'A',nome: '',prec: '',desc: '',img: '',
                  )));
                },
                ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 164,
                  child: BuilderCards('Higiene bebe'),
                  
                ),
              ),
              GestureDetector(
                child:titleProduct('Beleza', 'Ver mais'), 
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>telaEspec(
                      categoria: 'Beleza',state: 'A',nome: '',prec: '',desc: '',img: '',
                  )));
                },
                ),
                Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 164,
                  child: BuilderCards('Beleza'),
                  
                ),
              ),
              GestureDetector(
                child:titleProduct('Higiene', 'Ver mais'), 
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>telaEspec(
                      categoria: 'Higiene',state: 'A',nome: '',prec: '',desc: '',img: '',
                  )));
                },
                ),
                Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 164,
                  child: BuilderCards('Higiene'),
                  
                ),
              ),
              GestureDetector(
                child:titleProduct('Medicamentos', 'Ver mais'), 
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>telaEspec(
                      categoria: 'Medicamentos',state: 'A',nome: '',prec: '',desc: '',img: '',
                  )));
                },
                ),
                Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 164,
                  child: BuilderCards('Medicamentos'),
                  
                ),
              ),
            ],
          )
        )
      ),
    );
  }}