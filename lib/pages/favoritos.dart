import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TelaFavoritos extends StatefulWidget {
  @override
  _TelaFavoritosState createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<TelaFavoritos> {
  List<String> nome = [];
  List<String> preco = [];
  List<String> imgs = [];


  Future<void> carregarFavoritos() async {
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
    carregarFavoritos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: nome.isNotEmpty
          ? GridView.builder(
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
      )
          : const Center(child: Text('Nenhum produto favorito')),
    );
  }
}
