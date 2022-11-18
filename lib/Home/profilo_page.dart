import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Model/utente.dart';

class ProfiloPage extends StatefulWidget {
  const ProfiloPage({Key? key}) : super(key: key);

  @override
  State<ProfiloPage> createState() => ProfiloPageState();
}

class ProfiloPageState extends State<ProfiloPage> {
  final formKey= GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final cognomeController = TextEditingController();
  final emailController = TextEditingController();
  final etaController = TextEditingController();        //controller form
  final altezzaController = TextEditingController();
  final pesoController = TextEditingController();
  late String email='';
  late String nome='';
  late String cognome='';
  late String data='';
  late String stile='';
  late String genere='';
  late double altezza=0;
  late int eta=0;
  late double peso=0;
  late Utente? utente=null;
  Utente utenteMod= Utente(email: '', nome: '', cognome: '', stile: '', sesso: '', altezza: 0, peso: 0, eta: 0, kcal: 0, carbo: 0, grassi: 0, proteine: 0);
  final List<String> genderItems = [
    'Uomo',               //lista dropdown button sesso
    'Donna',
  ];
  final List<String> stileItems = [
    'Sedentario',
    'Poco Attivo',
    'Attivo',             //lista dropdown button stile di vita
    'Molto Attivo',
  ];




  @override
  void initState() {
    if (FirebaseAuth.instance.currentUser != null) {
        for (final providerProfile in FirebaseAuth.instance.currentUser!.providerData) {
          emailController.text= providerProfile.email!;
          email = providerProfile.email!;                 //prendo la mail dell'utente
          utenteMod.email=providerProfile.email!;
        }
    }

    return super.initState();
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Profilo'),
      ),
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Expanded(
              child: FutureBuilder<Utente?>(
                future: readUtente(),
                builder: (context, snapshot) {
                if(snapshot.hasData){
                utente=snapshot.data!;
                nomeController.text = utente!.nome;
                cognomeController.text = utente!.cognome;
                etaController.text = utente!.eta.toString();          //inizializzo le form con i dati dell'utente
                stile = utente!.stile;
                genere = utente!.sesso;
                altezzaController.text = utente!.altezza.toString();
                pesoController.text = utente!.peso.toString();
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: TextFormField(
                            controller: nomeController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              labelText: 'Nome',
                                labelStyle: (const TextStyle(
                                  color: Colors.green,))
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: TextFormField(
                            controller: cognomeController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.green),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              labelText: 'Cognome',
                                labelStyle: (const TextStyle(
                                  color: Colors.green,))
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                enabled: false,
                                disabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.green),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.green),
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                labelText: 'Email',
                                labelStyle: (const TextStyle(
                                  color: Colors.grey,))
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: DropdownButtonFormField(
                              value: genere,
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  labelText: 'Genere',
                                  labelStyle: (const TextStyle(
                                    color: Colors.green,))
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              hint: const Text(
                                'Genere',
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 24,

                              //buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                              //dropdownDecoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(15),
                              //),
                              items: genderItems
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                    ),
                                  ))
                                  .toList(),
                              onChanged: (value) {
                                genere = value!;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: DropdownButtonFormField(
                              value: stile,
                              decoration: InputDecoration(
                                //Add isDense true and zero Padding.
                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.green),
                                    borderRadius: BorderRadius.circular(35),
                                  ),
                                  labelText: 'Stile di Vita',
                                  labelStyle: (const TextStyle(
                                    color: Colors.green,))
                                //Add more decoration as you want here
                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                              ),
                              hint: const Text(
                                'Stile di Vita',
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 24,

                              items: stileItems
                                  .map((item) =>
                                  DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                    ),
                                  ))
                                  .toList(),
                              onChanged: (value) {
                                stile = value!;
                              },
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: TextFormField(
                                  controller: etaController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    labelText: 'Età',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: TextFormField(
                                  controller: pesoController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    labelText: 'Peso',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                                child: TextFormField(
                                  controller: altezzaController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          width: 2, color: Colors.green),
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    labelText: 'Altezza',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                          child: SizedBox(
                            height:60,
                            child: ElevatedButton(
                              style: ButtonStyle(

                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(35),
                                      )
                                  )
                              ),
                              child: const Text("AGGIORNA",style: TextStyle(
                                fontSize: 24,
                              ),),
                              onPressed: () {
                                if(nomeController.text==''){
                                  const snackBar = SnackBar(
                                    content: Text("Inserisci un nome"),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }else{
                                  if(cognomeController.text==''){
                                    const snackBar = SnackBar(            //Validazione form
                                      content: Text("Inserisci un cognome"),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }else{
                                    if(altezzaController.text=='' || (int.parse(altezzaController.text)>200 || int.parse(altezzaController.text)<130)){
                                      const snackBar = SnackBar(
                                        content: Text("Inserisci un'altezza tra 130 e 200 cm"),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }else{
                                      if(pesoController.text=="" || (double.parse(pesoController.text)>200 || double.parse(pesoController.text)<40)){
                                        const snackBar = SnackBar(
                                          content: Text("Inserisci un peso tra 40 e 200 kg"),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }else{
                                        if(etaController.text=="" || (int.parse(etaController.text)>90 || int.parse(etaController.text)<16)){
                                          const snackBar = SnackBar(
                                            content: Text("Inserisci un eta tra 16 e 90 anni"),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }else{
                                          utenteMod.nome = nomeController.text;
                                          utenteMod.cognome= cognomeController.text;
                                          utenteMod.eta= int.parse(etaController.text);
                                          utenteMod.peso= double.parse(pesoController.text);        //se valide ricalcolo kcal e nutrienti in base ai dati forniti
                                          utenteMod.altezza= int.parse(altezzaController.text);
                                          utenteMod.sesso=genere;
                                          utenteMod.stile=stile;
                                          if(utenteMod.sesso=='Uomo'){
                                            utenteMod.kcal = ((66.5 + (13.8*utenteMod.peso) + (5*utenteMod.altezza)) - (6.8*utenteMod.eta)).toInt();
                                            switch(utenteMod.stile){
                                              case 'Sedentario':
                                                utenteMod.kcal = (utenteMod.kcal*1.2).toInt();
                                                break;
                                              case 'Poco Attivo':
                                                utenteMod.kcal = (utenteMod.kcal*1.3).toInt();
                                                break;
                                              case 'Attivo':
                                                utenteMod.kcal = (utenteMod.kcal*1.4).toInt();
                                                break;
                                              case 'Molto Attivo':
                                                utenteMod.kcal = (utenteMod.kcal*1.5).toInt();
                                                break;
                                            }
                                          }else{
                                            utenteMod.kcal =  ((65.1 + (10.6*utenteMod.peso) + (4.5*utenteMod.altezza)) - (4.7*utenteMod.eta)).toInt();
                                            switch(utenteMod.stile){
                                              case 'Sedentario':
                                                utenteMod.kcal = (utenteMod.kcal*1.2).toInt();
                                                break;
                                              case 'Poco Attivo':
                                                utenteMod.kcal = (utenteMod.kcal*1.3).toInt();
                                                break;
                                              case 'Attivo':
                                                utenteMod.kcal = (utenteMod.kcal*1.4).toInt();
                                                break;
                                              case 'Molto Attivo':
                                                utenteMod.kcal = (utenteMod.kcal*1.5).toInt();
                                                break;
                                            }
                                          }
                                          utenteMod.carbo= ((utenteMod.kcal/100)*50)/4;
                                          utenteMod.proteine= ((utenteMod.kcal/100)*20)/4;
                                          utenteMod.grassi= ((utenteMod.kcal/100)*30)/8;
                                          updateUtente(utenteMod);
                                          const snackBar = SnackBar(                    //modifico utente
                                            content: Text('Utente Aggiornato'),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              snackBar);
                                        }
                                      }
                                    }
                                  }
                                }

                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                  }else{
                  return Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,        //schermata caricamento mentre vengono prelevati i dati
                    children: const [
                      Icon(Icons.loop),
                      Text('Caricamento'),
                    ],
                  ));
                }
                }
              )

              ),
            ),
        ],
      ),
    );
  }
   Future<Utente?> readUtente() async {                                       //leggo i dati dell'utente
     final docUtente = FirebaseFirestore.instance.collection('utenti').doc(email);
     final snapshot= await docUtente.get();
     if(snapshot.exists){
       return Utente.fromMap(snapshot.data()!);
     }
     return null;
  }                                                                     //modifico i dati dell'utente
  Future updateUtente(Utente utente) async {
    final docUtente = FirebaseFirestore.instance.collection('utenti').doc(utente.email);
    docUtente.update({
      'nome': utente.nome,
      'cognome': utente.cognome,
      'stile': utente.stile,
      'sesso': utente.sesso,
      'altezza': utente.altezza,
      'peso': utente.peso,
      'eta': utente.eta,
      'kcal': utente.kcal,
      'carbo': utente.carbo,
      'grassi': utente.grassi,
      'proteine': utente.proteine,
    });
  }
}

