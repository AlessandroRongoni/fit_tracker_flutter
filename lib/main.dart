// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:fit_tracker_flutter/Registrazione/nome_page.dart';
import 'package:fit_tracker_flutter/Home/home_page.dart';
import 'package:fit_tracker_flutter/inizio_page.dart';
import 'package:fit_tracker_flutter/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(                         //Inizializzo firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
  runApp(const MyApp());                        //Avvio app
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late StreamSubscription<User?> user;
  @override
  void initState() {          //Controllo se l'utente si è loggato in precedenza
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
      } else {
      }
    });
  }

  @override
  void dispose() {        //Metodo cancellazione
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(                       //Costruzione app
      title: 'FitTrackerFlutter',
      initialRoute:
      FirebaseAuth.instance.currentUser == null ? '/' : '/home',      //Se utente loggato vado sulla home altrimenti all'inizio
      routes: {                                 //Rotte principali
        '/': (context) => const InizioPage(),
        '/login': (context) => const LoginPage(),
        '/registrazione': (context) => const NomePage(),
        '/home': (context) => const HomePage(title: 'Login Demo'),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //home: const MyHomePage(title: 'FitTrackerFlutter'),
    );
  }
}

