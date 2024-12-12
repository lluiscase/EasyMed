import 'package:flutter/material.dart';
import 'package:flutterguys/pages/perfil.dart';
import 'package:flutterguys/pages/modules.dart';
import 'package:flutterguys/pages/produtos.dart';
void main() => runApp(HomePage());

Future<void> passagemItens(List<List<dynamic>> h)async{
  var categoria = await fetchCategorias();
  h.clear();
  for(var b in categoria){
     h.addAll(b.produtos.map((produto) => 
      [produto.nome,produto.descricao,produto.foto,produto.preco]
     ));
  }
}

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage> {
  List<Produtos> allProdutosList = [];
  List<Produtos> searchResult = [];
  List<List<dynamic>> passagem = [];
  int _selectedIndex = 0;
  final TextEditingController controller = TextEditingController();
  void listener(){
    search(controller.text);
  }

  void search(String query){
    if(query.isEmpty){
      setState(() {
        searchResult = allProdutosList;
      });
    }
    setState(() {
      searchResult = allProdutosList.where((e)=> e.nome.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

 Future<void> _load()async{
    await getallProdutos(allProdutosList);
    await passagemItens(passagem);
    setState(() {
      searchResult = allProdutosList;
    });
  }
  @override
  void initState(){
    _load();
    controller.addListener(listener);
    super.initState();
  }

  void _filterItems(String query) {
  setState(() {
    
  });
}
  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffF9FAFD),
        appBar: appbar('a','Olá Visitante'),
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
        body: Column(
          children: [
            Container(
              height: 30,
              margin: EdgeInsets.only(top: 15,left: 20,right: 20),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 226, 226, 226),
                  hintText: 'Pesquise...',
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 190, 190, 190),
                    fontSize: 12,
                    fontFamily: 'Montserrat'
                    ),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none
                    )

                ),
                controller: controller,
              ),
            ),
            if(controller.text.isNotEmpty)
            Expanded(
              child:  ListView.builder(
                itemCount:  searchResult.length,
                itemBuilder: (context,index){
                  final item = searchResult[index];
                  return Card(
                    child: ListTile(
                        title: Text(item.nome),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProdutosPage(
                      desc: item.descricao, 
                      nome: item.nome, 
                      prec: item.preco, 
                      img: item.foto)));
                        },
                    ),
                  );
                }
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [ 
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
                  titleProduct('Categorias', ''),
                  categorias(),
                  builderProd('Festival do bebê','Higiene bebe'),
                  Padbuildercards('Higiene bebe'),
                  builderProd('Beleza','Beleza'),
                    Padbuildercards('Beleza'),
                  builderProd('Higiene','Higiene'),
                    Padbuildercards('Higiene'),
                 builderProd('Medicamentos','Medicamentos'),
                    Padbuildercards('Medicamentos'),
                ],
              )
              )
              ),
            
          ]
            ),
        )
      );
  }
}
  