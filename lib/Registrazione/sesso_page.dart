import 'package:fit_tracker_flutter/Registrazione/altezza_page.dart';
import 'package:flutter/material.dart';

import '../Model/utente.dart';

class SessoPage extends StatefulWidget {
  final Utente utente;
  const SessoPage({super.key, required this.utente});

  @override
  State<SessoPage> createState() => SessoPageState();
}

class SessoPageState extends State<SessoPage> {
  late String genere='';
  bool checked=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greenbar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greenbar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greenbar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greybar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greybar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greybar.jpeg'))),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: SizedBox(
                      height: 15,
                      width:35,
                      child: Image(image: AssetImage('assets/images/greybar.jpeg'))),
                ),
              ],
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 25, 16, 0),
                child: SizedBox(
                    width: 130,
                    height:130,
                    child: Image(image: AssetImage('assets/images/apple_nobg.png'))),
              ),
            ),
            const Center(child: Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Text('Uomo o Donna?',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            )),
            ListTile(
              title: const Text('Uomo'),
              leading: Radio(
                value: 'Uomo',
                groupValue: genere,
                onChanged: (value)  {
                  setState(()  {
                    genere = value!;
                    checked=true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Donna'),
              leading: Radio(
                value: 'Donna',
                groupValue: genere,
                onChanged: (value) {
                  setState(() {
                    genere = value!;
                    checked=true;
                  });
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(50, 120, 50, 8),
              child: SizedBox(
                width:200,
                height:60,
                child: ElevatedButton(
                  style: ButtonStyle(

                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          )
                      )
                  ),
                  child: const Text("AVANTI",style: TextStyle(
                    fontSize: 24,
                  ),),
                  onPressed: () {
                    if(checked!= true){                   //Validazione form
                      const snackBar = SnackBar(
                        content: Text("Seleziona un'opzione"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      widget.utente.sesso=genere;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AltezzaPage(utente: widget.utente,),));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}