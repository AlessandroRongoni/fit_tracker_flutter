import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker_flutter/fit_tracker_database.dart';
import 'package:flutter/material.dart';

import '../Model/alimento.dart';

class AggiungiAlimentoPage extends StatefulWidget {
  final Alimento? alimento;
  const AggiungiAlimentoPage({Key? key, this.alimento}) : super(key: key);

  @override
  State<AggiungiAlimentoPage> createState() => AggiungiAlimentoPageState();
}

class AggiungiAlimentoPageState extends State<AggiungiAlimentoPage> {
  final formKey= GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final kcalController = TextEditingController();       //controller form
  final carboController = TextEditingController();
  final grassiController = TextEditingController();
  final proteineController = TextEditingController();
  late String nome='';
  late int kcal=0;
  late double carbo=0;
  late double grassi=0;
  late double proteine=0;
  late String utente='';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nomeController.dispose();
    kcalController.dispose();
    carboController.dispose();
    grassiController.dispose();
    proteineController.dispose();
    super.dispose();
  }

  Future aggiungiAlimento() async {             //aggiungo nuovo alimento
    final isValid = formKey.currentState!.validate();
    if(isValid){
      if (FirebaseAuth.instance.currentUser != null) {
        for (final providerProfile in FirebaseAuth.instance.currentUser!.providerData) {
          utente = providerProfile.email!;
        }
      }
      final alimento= Alimento(
        nome: nome,
        kcal: kcal,
        carbo: carbo,
        grassi: grassi,
        proteine: proteine,
        user: utente,
      );
      await FitTrackerDatabase.instance.create(alimento);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Nuovo Alimento',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ),
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
                  controller:kcalController,
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
                    labelText: 'Calorie',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller:carboController,
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
                    labelText: 'Carboidrati (g)',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller:grassiController,
                  keyboardType: TextInputType.number,
                  decoration:  InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    labelText: 'Grassi (g)',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  controller:proteineController,
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
                    labelText: 'Proteine (g)',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: ElevatedButton(
                  child: const Text("Aggiungi"),
                  onPressed: () {
                    nome=nomeController.text;
                    kcal=int.parse(kcalController.text);
                    carbo=double.parse(carboController.text);           //aggiungo alimento
                    grassi=double.parse(grassiController.text);
                    proteine=double.parse(proteineController.text);
                    aggiungiAlimento();
                    const snackBar = SnackBar(
                      content: Text('Nuovo Alimento Aggiunto'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    formKey.currentState?.reset();
                    nomeController.clear();
                    kcalController.clear();                 //pulisco la form
                    carboController.clear();
                    grassiController.clear();
                    proteineController.clear();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}