import 'package:fit_tracker_flutter/Registrazione/eta_page.dart';
import 'package:flutter/material.dart';

import '../Model/utente.dart';


class PesoPage extends StatefulWidget {
  final Utente utente;
  const PesoPage({super.key, required this.utente});

  @override
  State<PesoPage> createState() => PesoPageState();
}

class PesoPageState extends State<PesoPage> {
  final formKey= GlobalKey<FormState>();
  final pesoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 57, 15, 50),
        child: Column(
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
              child: Text('Qual è il tuo peso?',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            )),
            Form(
              key: formKey,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView(
                    //mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: TextFormField(
                          controller: pesoController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 2, color: Colors.green),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 2, color: Colors.green),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            labelText: 'Peso (kg) 40-200',
                          ),
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

                              if(pesoController.text==""){
                                const snackBar = SnackBar(
                                  content: Text("Inserisci un peso tra 40 e 200 kg"),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }else{                                //Validazione form
                                double peso= double.parse(pesoController.text);
                                if(peso<=200 && peso>=40){
                                  widget.utente.peso=peso;
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EtaPage(utente: widget.utente),));

                                }else{
                                  const snackBar = SnackBar(
                                    content: Text("Inserisci un peso tra 40 e 200 kg"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}