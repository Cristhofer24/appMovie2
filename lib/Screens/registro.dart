import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app2/Screens/inicioSesion.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 15, 14, 14),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: imagen_fondo(),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Crea tu cuenta",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                input_nombre(),
                const SizedBox(height: 15),
                input_email(),
                const SizedBox(height: 15),
                input_password(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: btn_registro(context),
                ),
                const SizedBox(height: 15),
                btn_inicioSesion(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

TextEditingController nombre = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

Widget input_nombre() {
  return CupertinoTextField(
    controller: nombre,
    placeholder: 'Ingresa tu nombre completo',
    prefix: Padding(
      padding: const EdgeInsets.all(10),
      child: FaIcon(FontAwesomeIcons.user, color: Colors.white),
    ),
    style: TextStyle(color: Colors.white),
    cursorColor: Colors.white,
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.3),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white.withOpacity(0.6)),
    ),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  );
}

Widget input_email() {
  return CupertinoTextField(
    controller: email,
    placeholder: 'Ingresa tu correo',
    prefix: Padding(
      padding: const EdgeInsets.all(10),
      child: FaIcon(FontAwesomeIcons.envelope, color: Colors.white),
    ),
    style: TextStyle(color: Colors.white),
    cursorColor: Colors.white,
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.3),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white.withOpacity(0.6)),
    ),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  );
}

Widget input_password() {
  return CupertinoTextField(
    controller: password,
    obscureText: true,
    placeholder: 'Contraseña',
    prefix: Padding(
      padding: const EdgeInsets.all(10),
      child: FaIcon(FontAwesomeIcons.lock, color: Colors.white),
    ),
    style: TextStyle(color: Colors.white),
    cursorColor: Colors.white,
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.3),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.white.withOpacity(0.6)),
    ),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  );
}

Widget btn_registro(context) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: ElevatedButton(
      onPressed: () {
        print('Registrarse presionado');
        registro(email.text, password.text, context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        side: BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5,
      ),
      child: Text(
        "Registrarse",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
  );
}

Widget btn_inicioSesion(context) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InicioSesionScreen()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 88, vertical: 15),
        side: BorderSide(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        elevation: 10,
      ),
      child: Text(
        "Iniciar Sesión",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ),
  );
}

void SuccesMessage(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          "Registro",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        content: Text(
          "Su registro se ha completado con éxito",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 10,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => InicioSesionScreen()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Aceptar",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> registro(emailAddress, password, context) async {
  try {
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

Widget imagen_fondo() {
  return Image.network(
    'https://imgs.search.brave.com/jrsX1iAwW-fvl2Xl4U9_fJ5ylO1Ns1WmAGysAIboHW0/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/Zm90by1ncmF0aXMv/c2ltYm9sb3MtY2lu/ZW1hdG9ncmFmaWEt/c29icmUtZm9uZG8t/bmVncm9fMjMtMjE0/NzY5ODk0Ni5qcGc_/c2VtdD1haXNfaHli/cmlk',
    fit: BoxFit.cover,
    width: double.infinity,
    height: double.infinity,
    alignment: Alignment.center,
  );
}
