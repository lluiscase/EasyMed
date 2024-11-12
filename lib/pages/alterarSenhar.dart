import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(NovaSenhaApp());

class NovaSenhaApp extends StatefulWidget {
  const NovaSenhaApp({super.key});

  @override
  NovaSenhaState createState() => NovaSenhaState();
}

class NovaSenhaState extends State<NovaSenhaApp> {
  final TextEditingController novaSenhaController = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _salvamentoNovaSenha() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('senhaUsuario', novaSenhaController.text);
    await prefs.setString('confirmarSenhaUsuario', confirmaSenhaController.text);
  }

  @override
  void dispose() {
    novaSenhaController.dispose();
    confirmaSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            leading: Image.asset(
              'assets/icons/logo.png',
              width: 47.33,
              height: 40,
            ),
            title: const Text("Olá!"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 170),
                  const Text(
                    'Criar uma nova senha',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: novaSenhaController,
                    decoration: const InputDecoration(
                      labelText: 'Nova senha',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: confirmaSenhaController,
                    decoration: const InputDecoration(
                      labelText: 'Confirme sua senha',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(180, 51),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      if (novaSenhaController.text.isEmpty || confirmaSenhaController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Os campos não podem estar vazios')),
                        );
                      } else if (novaSenhaController.text == confirmaSenhaController.text) {
                        await _salvamentoNovaSenha();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Senha salva com sucesso')),
                        );
                        novaSenhaController.clear();
                        confirmaSenhaController.clear();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('As senhas devem ser iguais')),
                        );
                      }
                    },
                    child: const Text(
                      'Salvar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
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
