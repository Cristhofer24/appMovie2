import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app2/Screens/apiMovie.dart';
import 'package:movie_app2/Screens/registro.dart';

class InicioSesionScreen extends StatelessWidget {
  const InicioSesionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            input_email(),
            const SizedBox(height: 20),
            input_password(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: btn_inicioSesion(context),
            ),
            btn_Registro(context)
          ],
        ),
      ),
    );
  }
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

Widget input_email() {
  return TextField(
    controller: email,
    decoration: InputDecoration(
      labelText: 'Correo Electrónico',
      hintText: 'Ingresa tu correo',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      prefixIcon: const Icon(Icons.email),
    ),
  );
}

Widget input_password() {
  return TextField(
    controller: password,
    obscureText: true,
    decoration: InputDecoration(
      labelText: 'Ingresa una contraseña',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      prefixIcon: const Icon(Icons.lock),
    ),
  );
}

Widget btn_inicioSesion(context) {

  return FilledButton(
    onPressed: () => {
      print('Iniciar Sesión presionado'),
      login(email.text, password.text, context)
    },

    child: Text(
      "Iniciar Sesión",
      style: TextStyle(fontSize: 18),
    ),
    style: ButtonStyle(
      backgroundColor:
          WidgetStatePropertyAll(const Color.fromARGB(255, 18, 99, 220)),
      padding: MaterialStatePropertyAll(
          const EdgeInsets.symmetric(horizontal: 80, vertical: 15)),
    ),
  );
}

Widget btn_Registro(context) {
  return FilledButton(
    onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegistroScreen()));
    },
    child: Text(
      "Registrate",
      style: TextStyle(fontSize: 18),
    ),
    style: ButtonStyle(
      backgroundColor:
          WidgetStatePropertyAll(const Color.fromARGB(255, 33, 99, 221)),
      padding: MaterialStatePropertyAll(
          const EdgeInsets.symmetric(horizontal: 88, vertical: 15)),
    ),
  );
}

void SuccesMessage(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Inicio de Sesión"),
          content: Text("Seison iniciado con exito"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ApiMovie()));
              },
              child: Text("Aceptar"),
            ),
          ],
        );
        //boton aceptar para cerrar el cuadro de dialogo
      });
}

Future<void> login(emailAddress, password, context) async {
try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailAddress,
    password: password
  );

  SuccesMessage(context);

} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
}
