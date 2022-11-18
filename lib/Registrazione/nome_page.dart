import 'package:fit_tracker_flutter/Registrazione/stile_di_vita_page.dart';
import 'package:flutter/material.dart';

import '../Model/utente.dart';


class NomePage extends StatefulWidget {
  const NomePage({super.key});

  @override
  State<NomePage> createState() => NomePageState();
}

class NomePageState extends State<NomePage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  Utente utente= Utente(email: '', nome: '', cognome: '', stile: '', sesso: '', altezza: 0, peso: 0, eta: 0, kcal: 0, carbo: 0, grassi: 0, proteine: 0);
  final nomeController = TextEditingController();
  final cognomeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nomeController.dispose();
    cognomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
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
                padding: EdgeInsets.all(8.0),
                child: Text('Conosciamoci meglio!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
              )),
              const Center(child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Text('Inserisci i tuoi dati', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
              )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    labelText: 'Nome',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller:  cognomeController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    labelText: 'Cognome',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 80, 50, 8),
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
                      child: const Padding(
                        padding: EdgeInsets.all(9.0),
                        child: Text(
                          "AVANTI",
                          style: TextStyle(
                            fontSize: 24,
                          ),

                        ),
                      ),
                      onPressed:()   {
                        if(nomeController.text=="" || cognomeController.text==""){        //Validazione form
                          const snackBar = SnackBar(
                            content: Text("Inserisci un nome e un cognome"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }else{
                          utente.nome=nomeController.text;
                          utente.cognome=cognomeController.text;
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StileDiVitaPage(utente: utente,),));
                        }
                      }
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}