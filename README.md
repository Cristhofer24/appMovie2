import 'package:flutter/material.dart';
import 'package:movie_app2/Screens/inicioSesion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'screens/inicioSesion.dart';
import 'screens/registro.dart';
import 'screens/apiMovie.dart';
import 'screens/multimedia.dart';

Future<void> main() async {
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: body(),
      ),
    );
  }
}

class body extends StatelessWidget {
  const body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InicioSesionScreen()
    );
  }
}

