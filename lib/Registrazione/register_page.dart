// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../Model/utente.dart';

class RegisterPage extends StatefulWidget {
  final Utente utente;
  const RegisterPage({super.key, required this.utente});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class RegisterPageState extends State<RegisterPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();            //controller form
  final passwordController = TextEditingController();
  final confermaPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confermaPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
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
                        child: Image(image: AssetImage('assets/images/greenbar.jpeg'))),
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
                child: Text('Un ultimo passo!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
              )),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator([                                 //autovalidazione email
                    RequiredValidator(errorText: "* Richiesto"),
                    EmailValidator(errorText: "Inserisci un indirizzo email valido"),
                  ]),
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email,),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    labelText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Richiesto"),            //autovalidazione password
                    MinLengthValidator(6,errorText: "La Password deve essere di 6 o più caratteri"),
                  ]),
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password,),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    labelText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val){                                           //autovalidazione conferma password
                    if(confermaPasswordController.text.isEmpty) {
                      return "* Richiesto";
                    }
                    if(val != passwordController.text) {
                      return "Le Password non corrispondo";
                    }
                    return null;
                  },
                  obscureText: true,
                  controller: confermaPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.password,),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.green),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(width: 2, color: Colors.red),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    labelText: 'Conferma Password',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
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
                          "REGISTRATI",
                          style: TextStyle(
                            fontSize: 24,
                          ),

                        ),
                      ),
                      onPressed:()  async {
                        if (formKey.currentState!.validate()) {                        //Se form validate creo l'account
                          try {
                            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            widget.utente.email=emailController.text;
                            if(widget.utente.sesso=='Uomo'){
                              widget.utente.kcal = ((66.5 + (13.8*widget.utente.peso) + (5*widget.utente.altezza)) - (6.8*widget.utente.eta)).toInt();
                              switch(widget.utente.stile){
                                case 'Sedentario':
                                  widget.utente.kcal = (widget.utente.kcal*1.2).toInt();
                                  break;                                                      //Calcolo kcal e nutrienti in base ai dati forniti
                                case 'Poco Attivo':
                                  widget.utente.kcal = (widget.utente.kcal*1.3).toInt();
                                  break;
                                case 'Attivo':
                                  widget.utente.kcal = (widget.utente.kcal*1.4).toInt();
                                  break;
                                case 'Molto Attivo':
                                  widget.utente.kcal = (widget.utente.kcal*1.5).toInt();
                                  break;
                              }
                            }else{
                              widget.utente.kcal =  (65.1 + (9.6*widget.utente.peso) + (1.9*widget.utente.altezza) - (4.7*widget.utente.eta)).toInt();
                              switch(widget.utente.stile){
                                case 'Sedentario':
                                  widget.utente.kcal = (widget.utente.kcal*1.2).toInt();
                                  break;
                                case 'Poco Attivo':
                                  widget.utente.kcal = (widget.utente.kcal*1.3).toInt();
                                  break;
                                case 'Attivo':
                                  widget.utente.kcal = (widget.utente.kcal*1.4).toInt();
                                  break;
                                case 'Molto Attivo':
                                  widget.utente.kcal = (widget.utente.kcal*1.5).toInt();
                                  break;
                              }
                            }
                            widget.utente.carbo= ((widget.utente.kcal/100)*50)/4;
                            widget.utente.proteine= ((widget.utente.kcal/100)*20)/4;
                            widget.utente.grassi= ((widget.utente.kcal/100)*30)/8;
                            creaUtente(utente: widget.utente);
                            Navigator.pushNamedAndRemoveUntil(                              //loggo l'utente sulla home
                                context, '/home', ModalRoute.withName('/home'));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                            } else if (e.code == 'email-already-in-use') {
                              const snackBar = SnackBar(                        //se email già in uso snackbar
                                content: Text("Email già in uso!"),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }
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
  Future creaUtente({required Utente utente}) async{                                        //Funzione crea utente
    final docUtente = FirebaseFirestore.instance.collection('utenti').doc(utente.email);
    await docUtente.set(utente.toMap());

  }
}

