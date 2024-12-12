import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutterguys/pages/cadastro.dart';
import 'package:flutterguys/pages/validacaoCodigo.dart';
import 'package:flutterguys/pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Login(),
    );
  }
}

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
    await prefs.setString('nomeUsuario', senhaController.text);
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
    return Scaffold(
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
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Faça Seu Login',
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF16697A),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
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
                      MaterialPageRoute(builder: (context) => Validacao()),
                    );
                  },
                  child: const Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                        color: Color(0xFFFC444C),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF16697A),
                  minimumSize: const Size(180, 51),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if (emailController.text.isNotEmpty &&
                      senhaController.text.isNotEmpty) {
                    _salvamentoNomeUsuario();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Login realizado com sucesso')),
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Preencha todos os campos')),
                    );
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blue, width: 2)),
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
                      MaterialPageRoute(builder: (context) => Cadastro()),
                    );
                  },
                  child: const Text(
                    'Cadastro',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
