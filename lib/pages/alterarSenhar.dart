import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const AlterarSenhar());

class AlterarSenhar extends StatefulWidget {
  const AlterarSenhar({super.key});

  @override
  AlterarSenharState createState() => AlterarSenharState();
}

class AlterarSenharState extends State<AlterarSenhar> {
  final TextEditingController novaSenhaController = TextEditingController();
  final TextEditingController novaSenhaController1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarSenhaUsuario();
  }

  Future<void> _carregarSenhaUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    novaSenhaController.text = prefs.getString('novaSenhar') ?? '';
    novaSenhaController1.text = prefs.getString('novaSenhar1') ?? '';
  }

  Future<void> _SalvarSenharUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('novaSenhar', novaSenhaController.text);
    await prefs.setString('novaSenhar1', novaSenhaController1.text);
  }

  @override
  void dispose() {
    novaSenhaController.dispose();
    novaSenhaController1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset(
            'assets/icons/logo.png',
            width: 47.33,
            height: 40,
          ),
          title: const Text("Olá!"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [ //
                  const Text(
                    'Troque Sua Senha',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: novaSenhaController,
                    decoration: const InputDecoration(
                      label: Text('Nova Senha'),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: novaSenhaController1,
                    decoration: const InputDecoration(
                      label: Text('Confirme a Senha'),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      _SalvarSenharUsuario();
                    },
                    child: const Text('Salvar Senha'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
