// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:fit_tracker_flutter/Menu%20Pasto/dettagli_alimento.dart';
import 'package:fit_tracker_flutter/fit_tracker_database.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';

import '../Model/alimento.dart';

class PersonalizzatiPage extends StatefulWidget {
  final String pasto;
  const PersonalizzatiPage({super.key, required this.pasto,});
  @override
  // ignore: no_logic_in_create_state
  State<PersonalizzatiPage> createState() => PersonalizzatiPageState();
}

class PersonalizzatiPageState extends State<PersonalizzatiPage> {
  PersonalizzatiPageState();
  late List<Alimento> alimenti;
  bool isLoading = false;
  late String email='';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState(){
    if (FirebaseAuth.instance.currentUser != null) {
      for (final providerProfile in FirebaseAuth.instance.currentUser!.providerData) {
        email = providerProfile.email!;
      }
    }
    super.initState();
    alimenti=[];
    refreshAlimenti();
  }


  Future refreshAlimenti() async {
    setState(() => isLoading = true);
    alimenti = await FitTrackerDatabase.instance.readAllAlimenti(email);
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
                    '   I Tuoi Alimenti   ',
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
              itemCount: alimenti.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DettagliAlimentoPage(alimentoId: alimenti[index].id!, pasto: widget.pasto))).then((value) => setState(() {refreshAlimenti();}));
                  },
                  child: ListTile(
                    title: Text(alimenti[index].nome),
                    subtitle: Text('Calorie: ${alimenti[index].kcal}  Tocca per i macronutrienti.'),
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