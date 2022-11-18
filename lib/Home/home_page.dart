// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_tracker_flutter/Menu%20Pasto/meal_page.dart';
import 'package:fit_tracker_flutter/fit_tracker_database.dart';
import 'package:fit_tracker_flutter/Home/profilo_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import '../Model/alimento.dart';
import '../Model/diario.dart';
import '../Model/utente.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {







  late Alimento alimento=const Alimento(nome: '', kcal: 0, carbo: 0, grassi: 0, proteine: 0, user: '');
  late List<Diario> diari;
  late List<Alimento?> alimenti;
  bool isLoading = false;
  late String email='';
  late String data='';
  late int calo=1;

  @override
  void initState(){
    if (FirebaseAuth.instance.currentUser != null) {
      for (final providerProfile in FirebaseAuth.instance.currentUser!.providerData) {
        email = providerProfile.email!;               //prendo email utente
      }
    }
    var now=DateTime.now();
    data= '${now.day}-${now.month}-${now.year}';
    super.initState();
    diari=[];
    alimenti=[alimento];
    refreshAlimentiPasto();
    refreshAlimenti();
  }
  int getKcalPasto(String pasto){
    var kcal=0;
    for (var dia in diari) {
      if(dia.pasto==pasto) {                  //calcolo calorie di un pasto
        int i=0;
        bool flag=false;
        while(i<alimenti.length && flag==false){
          if(alimenti[i]!.id == dia.alimento) {
            kcal = (kcal+(alimenti[i]!.kcal*dia.quantita)).toInt();
            flag=true;
          }
          i++;
        }
      }
    }
    return kcal;
  }
  Future refreshAlimentiPasto() async {             //prendo alimenti di un pasto
    setState(() => isLoading = true);

    diari = await FitTrackerDatabase.instance.readAllDiari(email,data,'Colazione');
    for (var dia in diari) {
      alimenti.add(await FitTrackerDatabase.instance.readAlimento(dia.alimento)) ;
    }
    setState(() => isLoading = false);
  }


  String _returnIconPath(String text) {
    late String iconPath='';                  //prendo path icona card pasto
    switch (text) {
      case 'Pranzo':
        {
          iconPath = 'assets/images/pranzo.png';
        }
        break;
      case 'Colazione':
        {
          iconPath = 'assets/images/colazione.png';
        }
        break;
      case 'Cena':
        {
          iconPath = 'assets/images/cena.png';
        }
        break;
      case 'Snack':
        {
          iconPath = 'assets/images/snack.png';
        }
        break;
    }
    return iconPath;
  }














  Future<Utente?> readUtente() async {                                                    //leggo dati utente per kcal e nutrienti
    final docUtente = FirebaseFirestore.instance.collection('utenti').doc(email);
    final snapshot= await docUtente.get();
    if(snapshot.exists){
      return Utente.fromMap(snapshot.data()!);
    }
    return null;
  }
  late Utente? utente= null;
  late int kcal=0;
  late double fat=0;
  late double carboidrati=0;
  late double pro=0;



  int getKcalGiorno(){        //calcolo calorie assunte giorno
    var kcal=0;
    for (var dia in diari) {
      int i=0;
      bool flag=false;
      while(i<alimenti.length && flag==false){
        if(alimenti[i]==null){
          alimenti.remove(alimenti[i]);
        }else{
          if(alimenti[i]!.id == dia.alimento) {
            kcal = (kcal+(alimenti[i]!.kcal*dia.quantita)).toInt();
            flag=true;
          }
          i++;
        }

      }
    }
    return kcal;
  }
  double getKcalPercentage(int kcal, int fabb){
    if(kcal<fabb){                                //calcolo percentuale calorie assunte, per progress bar
      return kcal/fabb;
    }else {
      return 1.0;
    }
  }

  double getCarboDay(){
    var carbo=0.0;                  //calcolo carbo assunti giorno
    for (var dia in diari) {
      int i=0;
      bool flag=false;
      while(i<alimenti.length && flag==false){
        if(alimenti[i]!.id == dia.alimento) {
          carbo = (carbo+(alimenti[i]!.carbo*dia.quantita));
          flag=true;
        }
        i++;
      }
    }
    return carbo;
  }
  double getCarboPercentage(double g, double fabb){
    if(g<fabb){                     //calcolo carbo assunti giorno percentuale, per progress bar
      return g/fabb;
    }else {
      return 1.0;
    }
  }

  double getProteineDay(){
    var pro=0.0;
    for (var dia in diari) {                  //calcolo proteine assunte giorno
      int i=0;
      bool flag=false;
      while(i<alimenti.length && flag==false){
        if(alimenti[i]!.id == dia.alimento) {
          pro = (pro+(alimenti[i]!.proteine*dia.quantita));
          flag=true;
        }
        i++;
      }
    }
    return pro;
  }
  double getProteinePercentage(double g, double fabb){
    if(g<fabb){                       //calcolo proteine assunte giorno percentuale, per progress bar
      return g/fabb;
    }else {
      return 1.0;
    }
  }

  double getGrassiDay(){
    var fat=0.0;
    for (var dia in diari) {                    //calcolo grassi assunti giorno
      int i=0;
      bool flag=false;
      while(i<alimenti.length && flag==false){
        if(alimenti[i]!.id == dia.alimento) {
          fat = (fat+(alimenti[i]!.grassi*dia.quantita));
          flag=true;
        }
        i++;
      }
    }
    return fat;
  }
  double getGrassiPercentage(double g, double fabb){
    if(g<fabb){
      return g/fabb;                      //calcolo grassi assunti giorno percentuale, per progress bar
    }else {
      return 1.0;
    }
  }

  Future refreshAlimenti() async {              //prendo gli alimenti
    setState(() => isLoading = true);

    diari = await FitTrackerDatabase.instance.readAllDiariDay(email,data);
    for (var dia in diari) {
      alimenti.add(await FitTrackerDatabase.instance.readAlimento(dia.alimento)) ;
    }
    setState(() => isLoading = false);
  }







  DateTime time = DateTime.now(); //prendo dateTime attuale per doppio tocco su indietro del telefono per uscire dall'app

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final differenza=DateTime.now().difference(time);
        final avviso= differenza >=const Duration(seconds: 2);
        time=DateTime.now();
        if(avviso){
          const messaggio='Premi di nuovo per uscire';
          Fluttertoast.showToast(msg:messaggio,fontSize:18, backgroundColor: const Color.fromARGB(100, 22, 44, 33),);
          return false;
        }else{                              //se faccio due tocchi in breve tempo sul back button del telefono esco dall'app
          Fluttertoast.cancel();
          SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () async {
              Navigator.pushNamedAndRemoveUntil(                //effettuo il logout e torno a InizioPage
                  context, '/', ModalRoute.withName('/'));
              await FirebaseAuth.instance.signOut();
            },
          ),
          title: const Text("Benvenuto in FitTracker", style: TextStyle(fontSize: 18),),
          actions: [
            IconButton(
              icon: const Icon(Icons.portrait),
              onPressed: () async {                                             //vado verso pagina utente
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfiloPage())).then((value) => setState(() {readUtente();}));
              },
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/app_bg.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Center(
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(35)),
                          ),
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${getKcalGiorno()}',                   //calorie assunte
                                              style:
                                              TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.grey.shade600),
                                            ),
                                            const Text(
                                              "ASSUNTE",
                                              style:
                                              TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child:
                                        FutureBuilder<Utente?>(
                                            future: readUtente(),
                                            builder: (context, snapshot) {
                                              if(snapshot.hasData){
                                                utente=snapshot.data!;
                                                kcal=utente!.kcal;
                                                return CircularPercentIndicator(
                                                  radius: 73.0,
                                                  lineWidth: 7.0,
                                                  animation: true,
                                                  percent: getKcalPercentage(getKcalGiorno(), kcal),
                                                  center: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(                                       //Progress bar calorie
                                                        '${utente!.kcal-getKcalGiorno()}',
                                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                                                      ),
                                                      const Text(
                                                        "Kcal Rimanenti",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                                                      ),
                                                    ],
                                                  ),
                                                  circularStrokeCap: CircularStrokeCap.round,
                                                  progressColor: Colors.purple,
                                                );
                                              }else{
                                                return const Text(
                                                  '0',
                                                  style:
                                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                                                );
                                              }
                                            }
                                        ),


                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "0",
                                              style:
                                              TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.grey.shade600),
                                            ),
                                            const Text(
                                              "BRUCIATE",                             //calorie bruciate, per futuri sviluppi (esercizi)
                                              style:
                                              TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child:
                                        FutureBuilder<Utente?>(
                                            future: readUtente(),
                                            builder: (context, snapshot) {
                                              if(snapshot.hasData){
                                                utente=snapshot.data!;
                                                carboidrati=utente!.carbo;
                                                var carbo=utente!.carbo.toStringAsFixed(1);
                                                return Column(
                                                    children: [
                                                      const Text(
                                                        "CARBOIDRATI",
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                                                        child: LinearPercentIndicator(                      //Progress bar carboidrati
                                                          animation: true,
                                                          lineHeight: 8.0,
                                                          animationDuration: 2500,
                                                          percent: getCarboPercentage(getCarboDay(), carboidrati),
                                                          barRadius: const Radius.circular(35),
                                                          progressColor: Colors.red,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${getCarboDay().toStringAsFixed(1)}/$carbo g',
                                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                                                      )
                                                    ]
                                                );
                                              }else{
                                                return const Text(
                                                  '0/0 gr',
                                                  style:
                                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                                                );
                                              }
                                            }
                                        ),
                                      ),

                                      Expanded(
                                        child:

                                        FutureBuilder<Utente?>(
                                            future: readUtente(),
                                            builder: (context, snapshot) {
                                              if(snapshot.hasData){
                                                utente=snapshot.data!;
                                                pro=utente!.proteine;
                                                var proteine= utente!.proteine.toStringAsFixed(1);
                                                return Column(
                                                  children: [
                                                    const Text(                             //progress bar proteine
                                                      "PROTEINE",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                                                      child: LinearPercentIndicator(
                                                        animation: true,
                                                        lineHeight: 8.0,
                                                        animationDuration: 1000,
                                                        percent: getProteinePercentage(getProteineDay(), pro),
                                                        barRadius: const Radius.circular(35),
                                                        progressColor: Colors.yellow,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${getProteineDay().toStringAsFixed(1)}/$proteine g',
                                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                                                    ),
                                                  ],
                                                );
                                              }else{
                                                return const Text(
                                                  '0/0 gr',
                                                  style:
                                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                                                );
                                              }
                                            }
                                        ),

                                      ),
                                      Expanded(
                                        child:
                                        FutureBuilder<Utente?>(
                                            future: readUtente(),
                                            builder: (context, snapshot) {
                                              if(snapshot.hasData){
                                                utente=snapshot.data!;
                                                fat=utente!.grassi;
                                                var grassi=utente!.grassi.toStringAsFixed(1);
                                                return Column(
                                                  children: [
                                                    const Text(                                 //progress bar grassi
                                                      "GRASSI",
                                                      style:
                                                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                                                      child: LinearPercentIndicator(
                                                        animation: true,
                                                        lineHeight: 8.0,
                                                        animationDuration: 2500,
                                                        percent: getGrassiPercentage(getGrassiDay(), fat),
                                                        barRadius: const Radius.circular(35),
                                                        progressColor: Colors.blue.shade700,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${getGrassiDay().toStringAsFixed(1)}/$grassi g',
                                                      style:
                                                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                                                    ),
                                                  ],
                                                );
                                              }else{
                                                return const Text(
                                                  '0/0 gr',
                                                  style:
                                                  TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                                                );
                                              }
                                            }
                                        ),

                                      ),
                                    ],
                                  )
                                ],
                              )
                          ),
                        ),
                      ),
                      Center(
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(35)),
                          ),
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),       //se clicco sulla card vado verso il menu pato relativo alla colazione
                            onTap: () async {
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => const MealPage(text: 'Colazione'))).then((value) => setState(() {refreshAlimenti();}) );
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(35)),
                            child:  SizedBox(
                              height: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding:  const EdgeInsets.fromLTRB(5, 12, 6, 12),                      //CARD COLAZIONE
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(_returnIconPath('Colazione')),
                                          ),
                                        ),
                                        width:80,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                      child: Text(
                                        'Colazione:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                                      child: Text(

                                        '${getKcalPasto('Colazione')} kcal' ,
                                        style:  TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(35)),
                          ),
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(                                     //se clicco sulla card vado verso il menu pato relativo al pranzo
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () async {
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => const MealPage(text: 'Pranzo'))).then((value) => setState(() {refreshAlimenti();}) );
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(35)),
                            child:  SizedBox(
                              height: 70,
                              child: Row(                                                 //CARD PRANZO
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding:  const EdgeInsets.fromLTRB(5, 12, 6, 12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(_returnIconPath('Pranzo')),
                                          ),
                                        ),
                                        width:80,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                      child: Text(
                                        'Pranzo:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                                      child: Text(

                                        '${getKcalPasto('Pranzo')} kcal' ,
                                        style:  TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(35)),
                          ),
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(                                               //se clicco sulla card vado verso il menu pato relativo alla cena
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () async {
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => const MealPage(text: 'Cena'))).then((value) => setState(() {refreshAlimenti();}) );
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(35)),
                            child:  SizedBox(
                              height: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(                                               //CARD CENA
                                    child: Padding(
                                      padding:  const EdgeInsets.fromLTRB(5, 12, 6, 12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(_returnIconPath('Cena')),
                                          ),
                                        ),
                                        width:80,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                      child: Text(
                                        'Cena:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                                      child: Text(

                                        '${getKcalPasto('Cena')} kcal' ,
                                        style:  TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(35)),
                          ),
                          color: Theme.of(context).colorScheme.surfaceVariant,        //se clicco sulla card vado verso il menu pato relativo agli snack
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () async {
                              await Navigator.push(context, MaterialPageRoute(builder: (context) => const MealPage(text: 'Snack'))).then((value) => setState(() {refreshAlimenti();}) );
                            },
                            borderRadius: const BorderRadius.all(Radius.circular(35)),
                            child:  SizedBox(
                              height: 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[                                         //CARD SNACK
                                  Expanded(
                                    child: Padding(
                                      padding:  const EdgeInsets.fromLTRB(5, 12, 6, 12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(_returnIconPath('Snack')),
                                          ),
                                        ),
                                        width:80,
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                      child: Text(
                                        'Snack:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(16, 12, 0, 12),
                                      child: Text(

                                        '${getKcalPasto('Snack')} kcal' ,
                                        style:  TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[400],
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}