import 'package:flutter/material.dart';
import 'package:flutterguys/pages/perfil/CodigoValidacao.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Validacao(),
    );
  }
}

class Validacao extends StatefulWidget {
  const Validacao({super.key});
  @override
  ValidacaoState createState() => ValidacaoState();
}

class ValidacaoState extends State<Validacao> {
  final TextEditingController emailController = TextEditingController();
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/icons/logo.png',
          width: 47.33,
          height: 40,
        ),
        title: const Text("Recuperar sua Senha"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza a coluna
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Text(
                'Código de validação',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF16697A),
                ),
              ),
              const SizedBox(height: 80),
              Container(
                constraints: const BoxConstraints(maxWidth: 378),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Container(
                padding: const EdgeInsets.all(10),
                constraints: const BoxConstraints(maxWidth: 300),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    const Text(
                      "I'm not a robot",
                      style: TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    Container(
                      width: 80,
                      height: 80,
                      child: Image.asset(
                        'assets/icons/recaptcha.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF16697A),
                    minimumSize: const Size(180, 51),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Por favor, preencha o email')),
                      );
                    } else if (!_isChecked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Por favor, marque a caixa "I\'m not a robot"')),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Codigovalidacao()),
                      );
                    }
                  },
                  child: const Text(
                    'Enviar código',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
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
