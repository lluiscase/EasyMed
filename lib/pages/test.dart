import 'dart:convert';
import 'package:http/http.dart' as http;

class Produtos {
  final String? id;
  final String? nome;
  final String? preco;
  final String? descricao;

  Produtos({required this.id, required this.nome, required this.preco, required this.descricao});

  factory Produtos.fromJson(Map<String, dynamic> json) {
    return Produtos(
      id: json['id'],
      nome: json['nome'],
      preco: json['preco'],
      descricao: json['descricao'] ?? '',
    );
  }
}

class Categoria {
  final String nome;
  List<Produtos> produtos;

  Categoria({required this.nome, required this.produtos});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    var produtoList = json['produtos'] as List?;
    List<Produtos> produtos = produtoList?.map((produtoJson) => Produtos.fromJson(produtoJson)).toList() ?? [];
    return Categoria(
      nome: json['nome'],
      produtos: produtos,
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

Future<void> printProdutos() async {
  List<Categoria> categorias;

  try {
    categorias = await fetchCategorias();
  } on Exception catch (e) {
    print("Não foi possível acessar as categorias: ${e.toString()}");
    return;
  }
  if (categorias.isNotEmpty) {
    for (var categoria in categorias) {
      print('Categoria: ${categoria.nome}');
      for (var produto in categoria.produtos) {
        print('Nome: ${produto.nome}');
        print('Preço: ${produto.preco}');
        print('Descrição: ${produto.descricao}');
      }
    }
  } else {
    print("Não há categorias disponíveis.");
  }
}

void main() async {
  //getProdutos("Beleza");
  //await printProdutos();
}
