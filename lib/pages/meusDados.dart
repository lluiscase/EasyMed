import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeusDados extends StatefulWidget {
  final Function(String) onNomeSalvo;

  const MeusDados({super.key, required this.onNomeSalvo});

  @override
  MeusDadosState createState() => MeusDadosState();
}

class MeusDadosState extends State<MeusDados> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();

  String nomeExibido = 'Visitante';

  @override
  void initState() {
    super.initState();
    _carregamentoDados();
  }

  Future<void> _carregamentoDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nomeController.text = prefs.getString('nomeUsuario') ?? '';
    emailController.text = prefs.getString('emailUsuario') ?? '';
    telefoneController.text = prefs.getString('telefoneUsuario') ?? '';
    cpfController.text = prefs.getString('cpfUsuario') ?? '';
    enderecoController.text = prefs.getString('enderecoUsuario') ?? '';

    setState(() {
      nomeExibido = nomeController.text.isNotEmpty ? nomeController.text : 'Visitante';
    });
  }

  Future<void> _salvamentoDosDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nomeUsuario', nomeController.text);
    await prefs.setString('emailUsuario', emailController.text);
    await prefs.setString('telefoneUsuario', telefoneController.text);
    await prefs.setString('cpfUsuario', cpfController.text);
    await prefs.setString('enderecoUsuario', enderecoController.text);

    widget.onNomeSalvo(nomeController.text);

    setState(() {
      nomeExibido = nomeController.text.isNotEmpty ? nomeController.text : 'Visitante';
    });
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    cpfController.dispose();
    enderecoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffF9FAFD),
          title: const Text(
            'Meus Dados',
            style: TextStyle(
              color: Color(0xff080F0F),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 0.0,
          leading: Container(
            decoration: BoxDecoration(
              color: const Color(0xffF7f8f8),
              borderRadius: BorderRadius.circular(1),
            ),
            margin: const EdgeInsets.all(8),
            child: Image.asset(
              'assets/icons/logo.png',
              fit: BoxFit.cover,
              width: 50,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/icons/return.png',
                  width: 50,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffF7f8f8),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                  nomeExibido,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome Completo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: telefoneController,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: cpfController,
                  decoration: const InputDecoration(
                    labelText: 'CPF',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: enderecoController,
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    _salvamentoDosDados();
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
