import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: Image.asset('assets/icons/logo.png', width: 47.43, height: 40),
            title: const Text("Olá Helena"),
            actions: [
              Image.asset(
                'assets/icons/return.png',
                width: 60,
                height: 50,
              ),
            ],
          ),
          body: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SizedBox(height: 50),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, size: 50),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Helena Bianchi",
                    style: TextStyle(fontSize: 20, color: Colors.blue,),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Meus Dados",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Retiradas",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Historico",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Cupons",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Sair",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ])
                ],
              )
            ],
          )
      ),
    );
  }
}
