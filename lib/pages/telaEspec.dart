import 'package:flutter/material.dart';
import 'package:flutterguys/pages/produtos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterguys/pages/modules.dart';

void main() => runApp(const TelaEspec(
    categoria: '', state: '', desc: '', nome: '', prec: '', img: ''));

class TelaEspec extends StatefulWidget {
  final String categoria;
  final String state;
  final String desc;
  final String nome;
  final String prec;
  final String img;

  const TelaEspec({
    super.key,
    required this.categoria,
    required this.state,
    required this.desc,
    required this.nome,
    required this.prec,
    required this.img,
  });

  @override
  TelaEspecState createState() => TelaEspecState();
}

class TelaEspecState extends State<TelaEspec> {
  List<String> nome = [];
  List<String> preco = [];
  List<String> imgs = [];

  Future<void> addProduto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Explicitly casting to List<String>
    List<String> nomesAtual = prefs.getStringList('nomes') ?? [];
    List<String> precoAtual = prefs.getStringList('precos') ?? [];
    List<String> imgAtual = prefs.getStringList('imagens') ?? [];

    String nome = widget.nome;
    String preco = widget.prec;
    String img = widget.img;

    if (!nomesAtual.contains(nome)) {
      nomesAtual.add(nome);
      precoAtual.add(preco);
      imgAtual.add(img);
    }

    await prefs.setStringList('nomes', nomesAtual);
    await prefs.setStringList('precos', precoAtual);
    await prefs.setStringList('imagens', imgAtual);

    setState(() {
      this.nome = nomesAtual;
      this.preco = precoAtual;
      this.imgs = imgAtual;
    });
  }

  Future<void> carregar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Explicitly casting to List<String>
    List<String> nomesAtual = prefs.getStringList('nomes') ?? [];
    List<String> precoAtual = prefs.getStringList('precos') ?? [];
    List<String> imgAtual = prefs.getStringList('imagens') ?? [];

    setState(() {
      nome = nomesAtual;
      preco = precoAtual;
      imgs = imgAtual;
    });
  }

  @override
  void initState() {
    super.initState();
    addProduto();
    carregar();
  }

  Widget changeScreen() {
    final String currentState = widget.state;
    if (currentState == 'Ver mais') {
      return buildStateA();
    } else {
      return buildStateB();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFD),
      appBar: AppBar(
        title: Text(widget.state),
      ),
      body: widget.state.isNotEmpty
          ? changeScreen()
          : const Center(child: CircularProgressIndicator()),
    );
  }

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
            childAspectRatio: 0.75,
          ),
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
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(8.0),
                width: 109,
                decoration: BoxDecoration(
                  color: const Color(0xffF9FAFD),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 10),
                      child: Image.network(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        snapshot.data![index].nome,
                        style: const TextStyle(
                          color: Color(0xff080F0F),
                          fontSize: 9,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                      child: Text(
                        'R\$${snapshot.data![index].preco}',
                        style: const TextStyle(
                          color: Color(0xfffc444c),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdutosPage(
                  nome: nome[index],
                  desc: widget.desc,
                  prec: preco[index],
                  img: imgs[index],
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(8.0),
            width: 109,
            decoration: BoxDecoration(
              color: const Color(0xffF9FAFD),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 10),
                  child: Image.network(
                    imgs[index],
                    width: 55,
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    nome[index],
                    style: const TextStyle(
                      color: Color(0xff080F0F),
                      fontSize: 9,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                  child: Text(
                    'R\$${preco[index]}',
                    style: const TextStyle(
                      color: Color(0xfffc444c),
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}