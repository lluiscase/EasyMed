import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MeusDados extends StatefulWidget {
  final Function(String) onNomeSalvo;

  const MeusDados({super.key, required this.onNomeSalvo});

  @override
  MeusDadosState createState() => MeusDadosState();
}

class MeusDadosState extends State<MeusDados> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController enderecoController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imagemPerfil;
  String? _caminhoImagemPerfil;

  String nomeExibido = 'Visitante';

  @override
  void initState() {
    super.initState();
    _carregamentoDados();
  }

  // Método para escolher a imagem
  Future<void> _escolherImagem() async {
    final XFile? imagemSelecionada = await _picker.pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _imagemPerfil = imagemSelecionada;
        _caminhoImagemPerfil = imagemSelecionada.path;
      });
    }
  }

  Future<void> _carregamentoDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString('emailUsuario') ?? '';
    telefoneController.text = prefs.getString('telefoneUsuario') ?? '';
    cpfController.text = prefs.getString('cpfUsuario') ?? '';
    enderecoController.text = prefs.getString('enderecoUsuario') ?? '';
    _caminhoImagemPerfil = prefs.getString('caminhoImagemPerfil');


    setState(() {
      nomeExibido = prefs.getString('nomeUsuario') ?? 'Visitante';
    });


    if (_caminhoImagemPerfil != null) {
      _imagemPerfil = XFile(_caminhoImagemPerfil!);
    }
  }


  Future<void> _salvamentoDosDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('emailUsuario', emailController.text);
    await prefs.setString('telefoneUsuario', telefoneController.text);
    await prefs.setString('cpfUsuario', cpfController.text);
    await prefs.setString('enderecoUsuario', enderecoController.text);
    await prefs.setString('nomeUsuario', nomeExibido);
    if (_caminhoImagemPerfil != null) {
      await prefs.setString('caminhoImagemPerfil', _caminhoImagemPerfil!);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    telefoneController.dispose();
    cpfController.dispose();
    enderecoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              GestureDetector(
                onTap: _escolherImagem,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue,
                  backgroundImage: _imagemPerfil != null
                      ? FileImage(File(_imagemPerfil!.path))
                      : null,
                  child: _imagemPerfil == null
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
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
                keyboardType: TextInputType.phone,
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
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(180, 51),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _salvamentoDosDados,
                child: const Text(
                  'Salvar',
                  style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
