import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

class InizioPage extends StatefulWidget {
  const InizioPage({super.key});
  @override
  State<InizioPage> createState() => InizioPageState();
}

class InizioPageState extends State<InizioPage> {
  late VideoPlayerController _controller;
  late VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener=(){
      setState((){});
    };                    //Controller video background
    _controller = VideoPlayerController.asset('assets/videos/videoapp.mp4')..addListener(listener)..setVolume(0)..initialize()..setLooping(true);
    _controller.play();
  }


  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            VideoPlayer(_controller),
            Container(
              color: const Color.fromARGB(100, 22, 44, 33),   //Opacità video
            ),
            Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center ,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(image: AssetImage('assets/images/color_logo_no_background.png')),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Text('La tua Applicazione per la', style: TextStyle(fontSize: 20,color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),

                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                        child: Text('nutrizione e una vita più sana', style: TextStyle(fontSize: 20,color: Colors.white,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
                                  "INIZIA",
                                  style: TextStyle(
                                    fontSize: 24,
                                  ),

                                ),
                              ),
                              onPressed:()   {
                                Navigator.pushNamed(context, '/registrazione');
                              }
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: SizedBox(
                          width:200,
                          height:60,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: const MaterialStatePropertyAll<Color>(Color.fromARGB(100, 22, 44, 33)),
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
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              onPressed:()  {
                                Navigator.pushNamed(context, '/login');
                              }
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ]
      ),
    );
  }
}