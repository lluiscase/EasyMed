import 'package:flutter/material.dart';
import 'package:flutterguys/pages/modules.dart';
import 'package:flutterguys/pages/produtos.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const telaEspec(
  categoria: '',
  state: '',
  desc: '',
  nome: '',
  prec: '',
  img: '',
));

class telaEspec extends StatefulWidget {
  final String categoria;
  final String state;
  final String desc;
  final String nome;
  final String prec;
  final String img;

  const telaEspec({
    super.key,
    required this.categoria,
    required this.state,
    required this.desc,
    required this.nome,
    required this.prec,
    required this.img,
  });

  @override
  telaEspecState createState() => telaEspecState();
}

class telaEspecState extends State<telaEspec> {
  List<String> nome = [];
  List<String> preco = [];
  List<String> imgs = [];

  // Método para adicionar produto aos favoritos
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

  // Método para carregar os itens do SharedPreferences
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

  // Método para determinar qual tela exibir
  Widget changeScreen() {
    final String currentState = widget.state;
    if (currentState == 'A') {
      return buildStateA();
    } else {
      return buildStateB();
    }
  }

  @override
  void initState() {
    super.initState();
    addProduto();
    verItens();
  }

  // Tela para o estado "A"
  Widget buildStateA() {
    return FutureBuilder(
        future: getProdutos(widget.categoria),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar categorias"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhuma categoria disponível"));
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.75),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProdutosPage(
                            nome: snapshot.data![index].nome,
                            desc: snapshot.data![index].descricao,
                            prec: snapshot.data![index].preco,
                            img: snapshot.data![index].foto,
                          ))).then((_) {
                    verItens();
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 109,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        snapshot.data![index].foto,
                        width: 75,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          return loadingProgress == null
                              ? child
                              : const CircularProgressIndicator();
                        },
                        errorBuilder: (context, url, stackTrace) {
                          return const Icon(Icons.error);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          snapshot.data![index].nome,
                          style: const TextStyle(
                              color: Color(0xff080F0F), fontSize: 9),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                        child: Text(
                          'R\$${snapshot.data![index].preco}',
                          style: const TextStyle(
                              color: Color(0xfffc444c), fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF9FAFD),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                ),
              );
            },
          );
        });
  }

  Widget buildStateB() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
            margin: const EdgeInsets.all(8.0),
            width: 109,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  imgs[index],
                  width: 75,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    return loadingProgress == null
                        ? child
                        : const CircularProgressIndicator();
                  },
                  errorBuilder: (context, url, stackTrace) {
                    return const Icon(Icons.error);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    nome[index],
                    style: const TextStyle(
                        color: Color(0xff080F0F), fontSize: 9),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                  child: Text(
                    'R\$${preco[index]}',
                    style: const TextStyle(
                        color: Color(0xfffc444c), fontSize: 10),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF9FAFD),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos')),
      body: nome.isNotEmpty && preco.isNotEmpty && imgs.isNotEmpty
          ? changeScreen()
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
