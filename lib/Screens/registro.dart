import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app2/Screens/inicioSesion.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Título principal centrado
              Text(
                'Crea tu cuenta',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 28,
                    ),
              ),
              const SizedBox(height: 10),
              // Descripción centrada
              Text(
                'Llena los campos para registrarte.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
              ),

              const SizedBox(height: 30),
              // Campos de texto
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre Completo',
                  hintText: 'Ingresa tu nombre completo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 20),
              input_email(),

              const SizedBox(height: 20),
              input_password(),
              const SizedBox(height: 30),
              // Botón de registro centrado
              btn_registro(context),
            ],
          ),
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

Widget btn_registro(context) {
  return FilledButton(
      onPressed: () {
        // Acción al registrarse
        print('Registrarse presionado');
        registro(email.text, password.text,context);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blueAccent),
        padding: MaterialStatePropertyAll(const EdgeInsets.symmetric(
          horizontal: 88,
          vertical: 15,
        )),
      ),
      child: const Text(
        'Registrarse',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ));
}

void SuccesMessage(context){
    showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text("Registro"),
      content: Text("Su registro se ha completado con exito"),
      
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> InicioSesionScreen()));
            },
            child: Text("Aceptar"),
          ),
        ],
    );
    //boton aceptar para cerrar el cuadro de dialogo
  } );
}



Future<void> registro(emailAddress, password,context) async {
  try {
    // ignore: unused_local_variable
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    SuccesMessage(context);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
