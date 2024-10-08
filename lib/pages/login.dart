import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterguys/pages/historico.dart';
import 'package:flutterguys/pages/home.dart';

void main() => runApp(Login());

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarNomeUsuario();
  }

  Future<void> _carregarNomeUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    senhaController.text = prefs.getString('senhaUsuario') ?? '';
    emailController.text = prefs.getString('emailUsuario') ?? '';
  }

  Future<void> _salvamentoNomeUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('senhaUsuario', senhaController.text);
    await prefs.setString('emailUsuario', emailController.text);
  }

  @override
  void dispose() {
    senhaController.dispose();
    emailController.dispose();
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Faça Seu Login',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 50),
                TextFormField(
                  controller: senhaController,
                  decoration: const InputDecoration(
                    label: Text('Senha'),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Historico()),
                      );
                    },
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(180, 51),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        senhaController.text.isNotEmpty) {
                      _salvamentoNomeUsuario();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login realizado com sucesso')),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                      emailController.clear();
                      senhaController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Preencha todos os campos')),
                      );
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(180, 51),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Historico()),
                      );
                    },
                    child: const Text(
                      'Cadastro',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
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
