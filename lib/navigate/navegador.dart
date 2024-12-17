import 'package:flutter/material.dart';
import 'package:movie_app2/screens/apiMovie.dart';
import 'package:movie_app2/Screens/multimedia.dart';
import 'package:movie_app2/Screens/inicioSesion.dart';
import 'package:movie_app2/Screens/registro.dart';

class Navegador extends StatelessWidget {
  const Navegador({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegación Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => const InicioSesionScreen(),
        '/inicioSesion': (context) => const InicioSesionScreen(),
        '/registro': (context) => const RegistroScreen(),
        '/movieApp': (context) => const ApiMovie(), // Ruta añadida para ApiMovie
        //'/multimedia': (context) => const Multimedia(),
        '/multimedia': (context) {
        final args = ModalRoute.of(context)!.settings.arguments as String;
        return Multimedia(videoUrl: args);
},
      },
    );
  }
}
