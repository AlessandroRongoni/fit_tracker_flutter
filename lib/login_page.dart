
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {              //Pagina Login
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class LoginPageState extends State<LoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();   //Controller Form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Center(
            child: ListView(

              children: [
                const SizedBox(
                    width: 130,
                    height:130,
                    child: Image(image: AssetImage('assets/images/apple_nobg.png'))),
                const Image(image: AssetImage('assets/images/title_black.png')),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Center(child: Text('Login', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 31),)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: MultiValidator([                                 //Validazione email automatica
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
                    validator: MultiValidator([                           //Validazione password automatica
                      RequiredValidator(errorText: "* Richiesto"),
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
                  padding: const EdgeInsets.fromLTRB(0, 35, 0, 8),
                  child: SizedBox(
                    height:60,
                    width: 200,
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
                            "ACCEDI",
                            style: TextStyle(
                              fontSize: 22,
                            ),

                          ),
                        ),
                        onPressed:()  async {
                          if (formKey.currentState!.validate()) {
                            try {
                              final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );                                              //Se la form è valida loggo l'utente e vado sulla home
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/home', ModalRoute.withName('/home'));
                            } on FirebaseAuthException catch (e) {                  //Altrimenti mostro una snackbar
                              if (e.code == 'user-not-found') {
                                const snackBar = SnackBar(content: Text('Utente non registrato'));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              } else if (e.code == 'wrong-password') {
                                const snackBar = SnackBar(content: Text('Password errata'));
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
      ),
    );
  }
}