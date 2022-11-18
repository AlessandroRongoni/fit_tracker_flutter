// ignore_for_file: use_build_context_synchronously


import 'package:fit_tracker_flutter/Menu%20Pasto/aggiungi_alimento_page.dart';
import 'package:fit_tracker_flutter/Menu%20Pasto/pasto_page.dart';
import 'package:fit_tracker_flutter/Menu%20Pasto/personalizzati_page.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages

class MealPage extends StatefulWidget {
  const MealPage({super.key, required this.text});
  final String text;
  @override
  // ignore: no_logic_in_create_state
  State<MealPage> createState() => MealPageState(text);
}

class MealPageState extends State<MealPage> {
  String text;
  int _selectedIndex=0;
  MealPageState(this.text,);
  void _onItemTapped(int index) {         //Controllo se cambio pagina dalla bottom navigation
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menù $text',
        ),
      ),
      body: Column(
        children: [
          [
            PastoPage(pasto: text),
            PersonalizzatiPage(pasto: text),      //Pagine di navigazione bottom navigation
            const AggiungiAlimentoPage(),
          ].elementAt(_selectedIndex)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.today),      //bottom navigation per la navigazione
            backgroundColor: Colors.green,
            label: text,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list),
            backgroundColor: Colors.green,
            label: 'Alimenti',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add),
            backgroundColor: Colors.green,
            label: 'Aggiungi',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.teal[900],
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}