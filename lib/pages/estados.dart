import 'package:flutter/material.dart';

void main() => runApp(const MyApp());


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

enum ScreenState{stateA, stateB, stateC}

class _HomePageState extends State<MyApp> {
  ScreenState _currentState = ScreenState.stateA;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mudança de Tela'),
      ),
      body: _buildContent(),
    );
  }
  
    Widget _buildContent() {
    switch(_currentState){
      case ScreenState.stateA:
        return buildStateA();
      case ScreenState.stateB:
        return buildStateB();
      case ScreenState.stateC:
        return buildStateC();
    }
  }
  
Widget buildStateA() {
  return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sua cesta está vazia...',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(35),
                child: Image.network(
                  'https://s3-alpha-sig.figma.com/img/44b1/9eae/018d5ac0085149065678b2ad96513192?Expires=1730073600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=HNjKrYdOD-YGd7e-tCoXojE-HrwOWZDP3Umgln8YqjDwfIV2cOVPMvJNHOJsL4zQL6~gpXxduyVWjMPhMgFwOpJdUEvHAOfUfYjXvG4eA7fsPhJ3kAgQRM3RjL-snX1RIHjhvfJTukp4gACUElQHONNiOYVMvpTFfACeKTUfbrV28zfYSSjCdxYCXsf10QumsrkATlPfe6LHjXvmE7YgpxO1fSczLY~4dYTDTsCfyI7o7378fj6uktPYssdH-LD8odgCmU9wP3yrP8gerHoQGITgtnOmyjdSHBBFiE1F91Yutc-VG6xe9ZwvabhwwAk-NWjNymrBmzfBk1oqZ4lAcw__',
                ),
              ),
              ]
  );
}

Widget buildStateC() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        color: Colors.amber,
      ),
      ElevatedButton(onPressed: (){
        setState(() {
          _currentState = ScreenState.stateC;
        });
      },
      child: Text('C'),
      )
    ],
  );
}

Widget buildStateB() {
  return Column(
    children: [
      Container(
        color: Colors.grey,
      )
    ],
  );
}

}
