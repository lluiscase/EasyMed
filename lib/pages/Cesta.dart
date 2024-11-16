import 'package:flutter/material.dart';

void main() => runApp(const CestaPage());

class CestaPage extends StatefulWidget {
  const CestaPage({super.key});

  @override
  CestaPageState createState() => CestaPageState();
}

class CestaPageState extends State<CestaPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xffF9FAFD),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(122),
          child: AppBar(
            title: Image.network(
              'https://raw.githubusercontent.com/lluiscase/EasyMed/refs/heads/main/assets/icons/logo_easyMeds.png',
              width: 165,
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  print('Clicou no carrinho');
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/icons/return.png',
                    width: 50,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffF7f8f8),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
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
               /*TextButton(
                      onPressed: (){}, 
                      child: Text(
                        'Finalizar pedido',
                      style: TextStyle(
                        color: Color(0xffFFFFFF)
                      ),),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 40,vertical: 15)),
                        backgroundColor: MaterialStatePropertyAll<Color>(Color(0xff16697A)),
                        
                      ),
                      ),*/
            ],
          ),
        ),
      ),
    );
  }
}
