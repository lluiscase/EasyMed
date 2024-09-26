import 'package:flutter/material.dart';
import 'package:flutterguys/pages/historico.dart';

void main() => runApp(const Perfil());

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  PerfilState createState() => PerfilState();
}

class PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/icons/logo.png', width: 47.43, height: 40),
          title: const Text("Olá Helena"),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Volta para a tela anterior
              },
              child: Image.asset(
                'assets/icons/return.png',
                width: 60,
                height: 50,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 20),
              const Text(
                "Helena Bianchi",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  children: [
                    const ListTile(
                      title: Text(
                        "Meus Dados",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const Divider(),
                    const ListTile(
                      title: Text(
                        "Retiradas",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const Divider(),
                    // Aqui está a opção "Histórico" com navegação.
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Historico(),
                          ),
                        );
                      },
                      child: const ListTile(
                        title: Text(
                          "Histórico",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const Divider(),
                    const ListTile(
                      title: Text(
                        "Cupons",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const Divider(),
                    const ListTile(
                      title: Text(
                        "Sair",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
