import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker_flutter/Menu%20Pasto/modifica_alimento_page.dart';
import 'package:fit_tracker_flutter/fit_tracker_database.dart';
import 'package:flutter/material.dart';

import '../Model/alimento.dart';
import '../Model/diario.dart';

class DettagliAlimentoPage extends StatefulWidget{
  final int alimentoId;
  final String pasto;
  const DettagliAlimentoPage({Key? key, required this.alimentoId, required this.pasto,}): super(key: key);
  
  @override
  State<DettagliAlimentoPage> createState() => DettagliAlimentoPageState();
}

class DettagliAlimentoPageState extends State<DettagliAlimentoPage>{
  late Alimento alimento= const Alimento(nome: '', kcal: 0, carbo: 0, grassi: 0, proteine: 0, user: '');
  bool isLoading = false;
  late String utente='';
  final quantitaController = TextEditingController();         //controller quantita per aggiunta nel diario
  late DateTime? date=null;
  @override
  void initState(){
    refreshAlimento();
    super.initState();

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    quantitaController.dispose();
    super.dispose();
  }

  Future aggiungiDiario(double quantita) async {              //aggiungo alimento nel diario
      if (FirebaseAuth.instance.currentUser != null) {
        for (final providerProfile in FirebaseAuth.instance.currentUser!.providerData) {
          utente = providerProfile.email!;
        }
        date = DateTime.now();
      final diario= Diario(
        pasto: widget.pasto,
        alimento: widget.alimentoId,
        quantita: quantita,
        giorno: '${date!.day}-${date!.month}-${date!.year}',
        utente: utente,
      );
      await FitTrackerDatabase.instance.createDiario(diario);
    }
  }

  Future refreshAlimento() async {            //prendo l'alimento
    setState(() => isLoading = true);
    alimento = (await FitTrackerDatabase.instance.readAlimento(widget.alimentoId))!;
    setState(() => isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Dettagli'),
        actions: [modificaButton(),deleteButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  alimento.nome,
                  style: const TextStyle(fontSize: 35,),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                  'INFO NUTRIZIONALI PER 100g DI PRODOTTO:',
                style: TextStyle(fontSize: 18,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Text(
                    'Calorie [kcal]:   ',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),
                  ),
                  Text(
                    '${alimento.kcal}',
                    style: TextStyle(color: Colors.grey.shade600,fontSize: 18,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Text(
                    'Carboidrati [g]:   ',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),
                  ),
                  Text(
                    '${alimento.carbo}',
                    style: TextStyle(color: Colors.grey.shade600,fontSize: 18,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Text(
                    'Grassi [g]:   ',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),
                  ),
                  Text(
                    '${alimento.grassi}',
                    style: TextStyle(color: Colors.grey.shade600,fontSize: 18,),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
              child: Row(
                children: [
                  const Text(
                    'Proteine [g]:   ',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,),
                  ),
                  Text(
                    '${alimento.proteine}',
                    style: TextStyle(color: Colors.grey.shade600,fontSize: 18,),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TextFormField(
                controller:quantitaController,
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
                  labelText: 'Quantità',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: ElevatedButton(
                  child: const Text(
                    "Aggiungi al Diario",
                  ),
                  onPressed: () {
                    if(quantitaController.text==""){          //se quantita inserita aggiungo l'alimento nel diario
                      const snackBar = SnackBar(
                        content: Text("Inserisci una quantità"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      aggiungiDiario(double.parse(quantitaController.text));
                      const snackBar = SnackBar(
                        content: Text('Alimento aggiunto al diario'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                  },
                ),
              ),
            ),
          ],
        ),
        ),
      );
  }

  Widget deleteButton() => IconButton(        //bottone elimina alimento
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await FitTrackerDatabase.instance.delete(widget.alimentoId);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  );

  Widget modificaButton() => IconButton(        //bottone modifica alimento che porta alla relativa page
    icon: const Icon(Icons.edit_outlined),
    onPressed: () async {
      if(isLoading) return;

      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ModificaAlimentoPage(alimento: alimento),));
      refreshAlimento();
    }
  );
}