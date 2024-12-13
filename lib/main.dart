import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movie_app2/Screens/multimedia.dart';
import 'firebase_options.dart';
import 'screens/inicioSesion.dart';
import 'screens/registro.dart';
import 'screens/apiMovie.dart';
//import 'screens/multimedia.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura la inicialización correcta
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const InicioSesionScreen(), // Pantalla inicial
        '/registro': (context) => const RegistroScreen(),
        '/movieApp': (context) => const ApiMovie(),
        '/multimedia': (context) => const Multimedia(),
      },
    );
  }
}
