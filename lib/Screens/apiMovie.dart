import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app2/Screens/multimedia.dart';

class ApiMovie extends StatelessWidget {
  const ApiMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Videos Musicales"),
      ),
      body: listViewLocal(context),
    );
  }

  Future<List> jsonLocal(context) async {
    try {
      final jsonString =
          await DefaultAssetBundle.of(context).loadString("assets/data/movie.json");
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return jsonMap['movies']; // Accede al campo "movies" del JSON
    } catch (e) {
      print("Error al cargar JSON: $e");
      return []; // Devuelve una lista vacía en caso de error
    }
  }

  Widget listViewLocal(context) {
    return FutureBuilder(
      future: jsonLocal(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Indicador de carga
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10.0),
                  leading: GestureDetector(
                    onTap: () {
                      // Navegar a la pantalla Multimedia y pasar el enlace del video como argumento
                      Navigator.pushNamed(
                        context,
                        '/multimedia', // Ruta para Multimedia
                        arguments: item['video_url'], // Pasamos el videoUrl
                      );
                    },
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        item['image'],
                        fit: BoxFit.contain, // Muestra la imagen completa
                      ),
                    ),
                  ),
                  title: Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['description']),
                      const SizedBox(height: 5),
                      Text("Categoría: ${item['category']}", style: const TextStyle(fontStyle: FontStyle.italic)),
                      Text("Duración: ${item['duration']}"),
                      Text("Año: ${item['release_year']}"),
                      Text("Rating: ${item['rating']}"),
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text("Datos no encontrados"));
        }
      },
    );
  }
}
