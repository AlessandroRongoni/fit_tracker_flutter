import 'package:fit_tracker_flutter/Registrazione/sesso_page.dart';
import 'package:flutter/material.dart';

import '../Model/utente.dart';

class StileDiVitaPage extends StatefulWidget {
  final Utente utente;
  const StileDiVitaPage( {super.key, required this.utente,});

  @override
  State<StileDiVitaPage> createState() => StileDiVitaPageState();
}

class StileDiVitaPageState extends State<StileDiVitaPage> {
  late String stile='';
  bool checked= false;
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
              child: Text('Scegli il tuo stile di vita!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            )),
            ListTile(
              title: const Text('Sedentario'),
              leading: Radio(
                value: 'Sedentario',
                groupValue: stile,
                onChanged: (value)  {
                  setState(()  {
                    stile = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Poco Attivo'),
              leading: Radio(
                value: 'Poco Attivo',
                groupValue: stile,
                onChanged: (value) {
                  setState(() {
                    stile = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Attivo'),
              leading: Radio(
                value: 'Attivo',
                groupValue: stile,
                onChanged: (value) {
                  setState(() {
                    stile = value!;
                    checked= true;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Molto Attivo'),
              leading: Radio(
                value: 'Molto Attivo',
                groupValue: stile,
                onChanged: (value) {
                  setState(() {
                    stile = value!;
                    checked= true;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 8),
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
                  child: const Text("AVANTI", style: TextStyle(
                    fontSize: 24,
                  ),),
                  onPressed: () {
                    if(checked!= true){               //Validazione form
                      const snackBar = SnackBar(
                        content: Text("Seleziona un'opzione"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      widget.utente.stile=stile;
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SessoPage(utente: widget.utente,),));
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