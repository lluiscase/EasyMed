import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const AlterarSenhaApp());

class AlterarSenhaApp extends StatefulWidget {
  const AlterarSenhaApp({super.key});

  @override
  AlterarSenhaState createState() => AlterarSenhaState();
}

class AlterarSenhaState extends State<AlterarSenhaApp> {
  final TextEditingController novaSenhaController = TextEditingController();
  final TextEditingController novaSenhaController1 = TextEditingController();
  final TextEditingController confirmaSenhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarSenhaUsuario();
  }


  Future<void> _carregarSenhaUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    novaSenhaController.text = prefs.getString('novaSenha') ?? '';
    novaSenhaController1.text = prefs.getString('novaSenha1') ?? '';
  }


  Future<void> _salvarSenhaUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('novaSenha', novaSenhaController.text);
    await prefs.setString('novaSenha1', novaSenhaController1.text);
    await prefs.setString('senhaUsuario', novaSenhaController.text);
    await prefs.setString('confirmarSenhaUsuario', confirmaSenhaController.text);
  }

  @override
  void dispose() {
    novaSenhaController.dispose();
    novaSenhaController1.dispose();
    confirmaSenhaController.dispose();
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
          title: const Text("Alterar Senha"),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 170),
                const Text(
                  'Crie sua nova senha',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: novaSenhaController,
                  decoration: const InputDecoration(
                    labelText: 'Nova Senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: novaSenhaController1,
                  decoration: const InputDecoration(
                    labelText: 'Confirme a Senha',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () async {
                    if (novaSenhaController.text.isEmpty || confirmaSenhaController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Os campos não podem estar vazios')),
                      );
                    } else if (novaSenhaController.text == confirmaSenhaController.text) {
                      await _salvarSenhaUsuario();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Senha salva com sucesso')),
                      );
                      novaSenhaController.clear();
                      novaSenhaController1.clear();
                      confirmaSenhaController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('As senhas devem ser iguais')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(180, 51),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Salvar Senha',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
