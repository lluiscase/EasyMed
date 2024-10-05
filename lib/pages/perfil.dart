import 'package:flutter/material.dart';
import 'package:flutterguys/pages/historico.dart';
import 'package:flutterguys/pages/meusDados.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterguys/pages/retiradas.dart';

void main() => runApp(const Perfil());

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  PerfilState createState() => PerfilState();
}

class PerfilState extends State<Perfil> {
  String nomeUsuario = 'Visitante';

  @override
  void initState() {
    super.initState();
    _carregaNomeUsuario();
  }

  Future<void> _carregaNomeUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuario = prefs.getString('nomeUsuario') ?? 'Visitante';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading:
              Image.asset('assets/icons/logo.png', width: 47.43, height: 40),
          title: Text("Olá!, $nomeUsuario"),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
              Text(
                nomeUsuario,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  children: [
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MeusDados(
                              onNomeSalvo: (String novoNome) {
                                setState(() {
                                  nomeUsuario = novoNome.isNotEmpty
                                      ? novoNome
                                      : 'Visitante';
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: const ListTile(
                        title: Text(
                          "Meus Dados",
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Retiradas()));
                      },
                      child: const ListTile(
                        title:
                            Text("Retiradas", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    const Divider(),
                    const ListTile(
                      title: Text(
                        "Sair",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const Divider(),
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
