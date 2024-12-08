import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const telaEspec(categoria: '', state: '', desc: '', nome: '', prec: '', img: ''));

class telaEspec extends StatefulWidget {
  final String categoria;
  final String state;
  final String desc;
  final String nome;
  final String prec;
  final String img;

  const telaEspec({super.key, required this.categoria, required this.state, required this.desc, required this.nome, required this.prec, required this.img});

  @override
  telaEspecState createState() => telaEspecState();
}

class telaEspecState extends State<telaEspec> {
  List<String> nome = [];
  List<String> preco = [];
  List<String> imgs = [];


  Future<void> addProduto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> nomesatual = prefs.getStringList('nomes') ?? [];
    List<String> precoatual = prefs.getStringList('precos') ?? [];
    List<String> imgatual = prefs.getStringList('imagens') ?? [];

    String nome = widget.nome;
    String preco = widget.prec;
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
    return Scaffold(
      appBar: AppBar(title: Text('Produtos')),
      body: nome.isNotEmpty && preco.isNotEmpty && imgs.isNotEmpty
          ? buildGrid()
          : Center(child: CircularProgressIndicator()),
    );
  }


  Widget buildGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: nome.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            print('Produto ${nome[index]} clicado');
          },
          child: Container(
            margin: EdgeInsets.all(8.0),
            width: 109,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 10),
                  child: Image.network(
                    imgs[index],
                    width: 75,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) {
                      return loadingProgress == null
                          ? child
                          : CircularProgressIndicator();
                    },
                    errorBuilder: (context, url, stackTrace) {
                      return Icon(Icons.error);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    nome[index],
                    style: TextStyle(color: Color(0xff080F0F), fontSize: 9),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                  child: Text(
                    'R\$${preco[index]}',
                    style: TextStyle(color: Color(0xfffc444c), fontSize: 10),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xffF9FAFD),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
