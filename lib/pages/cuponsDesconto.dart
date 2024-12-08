import 'package:flutter/material.dart';
import 'dart:math';

class Cupom {
  final String titulo;
  final String botao;
  final String detalhes;

  Cupom({
    required this.titulo,
    required this.botao,
    required this.detalhes,
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, Helena!'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            ),
                ],
             ),
        ),
    },

class TelaCupons extends StatelessWidget {
  final List<Cupom> cupons = [
    Cupom(
      titulo: '20% OFF em produtos de beleza, acima de R\$90,00',
      botao: 'Resgatar',
      detalhes: 'Válido até 03/11/2024',
    ),
    Cupom(
      titulo: '50% OFF na sua primeira compra',
      botao: 'Resgatar',
    ),
    Cupom(
      titulo: 'Ganhe 10% OFF em cuidados pessoais e vitaminas',
      botao: 'Resgatar',
      detalhes: 'Válido até 01/12/2024',
    ),
    Cupom(
      titulo: 'Ganhe 50% OFF em produtos Wella',
      botao: 'Expirado',
      detalhes: 'Válido até 12/11/2024',
    ),

  ];

}
