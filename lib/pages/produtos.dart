import 'package:flutter/material.dart';
import './modules.dart';

void main() => runApp(const ProdutosPage());

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  ProdutosPageState createState() => ProdutosPageState();
}

class ProdutosPageState extends State<ProdutosPage>{
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: appbar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Colors.red,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: (){}, 
                      child: Text('<'))
                      ),
                  Expanded(child:Text('Detalhes do produto',style: TextStyle(fontSize: 15),textAlign: TextAlign.center,)),
                  
                ],
              ),
            ),
        Container(
          width: double.infinity,
          color: Colors.blueAccent,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.heart_broken)),
              Center(child: Image.network('https://raw.githubusercontent.com/lluiscase/EasyMed/refs/heads/main/assets/icons/chupeta.png')),
              Align(alignment:Alignment.centerLeft, child:Text('Nome do produto',textAlign: TextAlign.start,)),
              Align(alignment:Alignment.centerLeft, child:Text('Preco do produto',textAlign: TextAlign.start,)),
              Center(
                child: 
                  TextButton(onPressed: (){}, child: Text('Adicionar à cesta')),
              ),
               Divider(
                    color: Colors.black,
                    thickness: 2,
              ),
            ],
            ),
        ),
        Container(
          width: double.infinity,
          color: Colors.yellow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Descrição',style: TextStyle(
                  fontSize: 20
                ),),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('fadsfasfwfawfasdsa'),
            )
          ],
          ),
        )
          ],
        ),
      ),
    );
}
}