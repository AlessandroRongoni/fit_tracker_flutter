// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:fit_tracker_flutter/fit_tracker_database.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';


import '../Model/alimento.dart';
import '../Model/diario.dart';

class PastoPage extends StatefulWidget {
  final String pasto;
  const PastoPage({super.key, required this.pasto,});
  @override
  State<PastoPage> createState() => PastoPageState();
}

class PastoPageState extends State<PastoPage> {


  PastoPageState();
  late Alimento? alimento=null;
  late List<Diario> diari;                  //inizializzazione variabili
  late List<Alimento?> alimenti;
  bool isLoading = false;
  late String email='';
  late String data='';
  final TextEditingController modificaController = TextEditingController();     //controller modifica quantita diario

  @override
  void initState(){
    if (FirebaseAuth.instance.currentUser != null) {
      for (final providerProfile in FirebaseAuth.instance.currentUser!.providerData) {    //prendo l'email dell'utente
        email = providerProfile.email!;
      }
    }
    var now=DateTime.now();
    data= '${now.day}-${now.month}-${now.year}';        //prendo la data di oggi
    super.initState();
    diari=[];
    alimenti=[];
    refreshAlimenti();
  }

  String getAlimento(int index)  {          //prendo il nome e le calorie dell'alimento in base alla quantita selezionata
    int i=0;
    while (i<alimenti.length) {
      if(alimenti[i]==null){
        alimenti.remove(alimenti[i]);
      }else{
        if(alimenti[i]!.id==diari[index].alimento){
          return '${alimenti[i]!.nome} Kcal: ${(alimenti[i]!.kcal*diari[index].quantita).toStringAsFixed(1)}';
        }
      }
    i++;
    }
    return '';
  }

  void modificaDiario(Diario diario,String stringa) async{        //modifico quantita alimento nel diario
    diario.quantita=double.parse(stringa);
    await FitTrackerDatabase.instance.updateDiario(diario);
  }


  Future refreshAlimenti() async {      //prendo gli alimenti dal db
    setState(() => isLoading = true);

    diari = await FitTrackerDatabase.instance.readAllDiari(email,data,widget.pasto);
    for (var dia in diari) {
      alimenti.add(await FitTrackerDatabase.instance.readAlimento(dia.alimento)) ;
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context,) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Container(
                decoration:  BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(35))
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    '   Il Tuo Pasto   ',
                    style: TextStyle(fontSize: 30),
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Container(
              width: 340,
              height: 3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/separatore.png')
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: diari.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(               //se clicco su un alimento del diario alert dialog elimina-modifica
                          title: const Center(
                            child: Text(
                                'Elimina o Modifica',
                                style: TextStyle(fontSize: 18)
                            ),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children : <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      child: const Text('Elimina'),
                                      onPressed: () async {
                                        await FitTrackerDatabase.instance.deleteDiario(diari[index].id!);
                                        setState(() {diari.removeAt(index);});
                                        Navigator.of(context).pop();
                                      }),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      child: const Text('Modifica'),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        await showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            modificaController.text=diari[index].quantita.toString();
                                            return AlertDialog(
                                              title: Padding(
                                                padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                                                child: TextField(
                                                  controller: modificaController,
                                                  decoration: InputDecoration(
                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(width: 2, color: Colors.green),
                                                        borderRadius: BorderRadius.circular(35),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(width: 2, color: Colors.green),
                                                        borderRadius: BorderRadius.circular(35),
                                                      ),
                                                      labelText: 'Quantità',
                                                      labelStyle: (const TextStyle(color: Colors.grey,))
                                                  ),
                                                ),
                                              ),
                                              content:
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children : <Widget>[
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: ElevatedButton(
                                                          child: const Text('Annulla'),
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          }),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: ElevatedButton(
                                                          child: const Text('Modifica'),
                                                          onPressed: () async {
                                                            if(modificaController.text==""){          //Validazione form
                                                              const snackBar = SnackBar(
                                                                content: Text("Inserisci una Quantità"),
                                                              );
                                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                            }else{
                                                              modificaDiario(diari[index],modificaController.text);
                                                              setState(() {refreshAlimenti();});                    //refresh pagina pasto
                                                              const snackBar = SnackBar(
                                                                content: Text("Modifica Effettuata"),
                                                              );
                                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                              Navigator.of(context).pop();
                                                            }

                                                          }),
                                                    ),
                                                  ),
                                                ],

                                              ),
                                            );
                                          },
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: ListTile(
                    title: Text(getAlimento(index)),
                    subtitle: Text('Quantità (per 100g): ${diari[index].quantita}  Tocca per operazioni.'),
                    isThreeLine: true,
                    dense: true,
                    trailing: const Icon(Icons.more_vert),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}