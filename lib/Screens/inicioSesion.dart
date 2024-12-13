
import 'package:flutter/material.dart';
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
            const TextField(
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 20),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),

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

Widget btn_inicioSesion(context){
  return FilledButton(onPressed: ()=>(),
   child: Text("Iniciar Sesión", style: TextStyle(fontSize: 18),),
   style: ButtonStyle( backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 18, 99, 220)),

   padding: MaterialStatePropertyAll(const EdgeInsets.symmetric(horizontal: 80, vertical: 15)),
    ),
   
   );
}
Widget btn_Registro(context){
  return FilledButton(onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistroScreen()));
  },
   child: Text("Registrate", style: TextStyle(fontSize: 18),),

   style: ButtonStyle( backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 33, 99, 221)), 

   padding: MaterialStatePropertyAll(const EdgeInsets.symmetric(horizontal: 88, vertical: 15)),
   ),
   );
}