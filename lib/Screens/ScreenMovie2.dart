import 'package:flutter/material.dart';
import 'package:movie_app2/Screens/trailerScreen.dart';
import 'package:movie_app2/service/movieApiService.dart';
import 'package:movie_app2/Screens/multimedia.dart';

class PeliculasPopularesScreen2 extends StatefulWidget {
  @override
  _PeliculasPopularesScreenState createState() =>
      _PeliculasPopularesScreenState();
}

class _PeliculasPopularesScreenState extends State<PeliculasPopularesScreen2> {
  late Future<List> _peliculas;

  @override
  void initState() {
    super.initState();
    _peliculas = TMDBService().obtenerPeliculasPopulares();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas Populares'),
      ),
      body: FutureBuilder<List>(
        future: _peliculas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay películas para mostrar'));
          }

          final peliculas = snapshot.data!;

          return ListView.builder(
            itemCount: peliculas.length,
            itemBuilder: (context, index) {
              final pelicula = peliculas[index];
              final videoUrl = pelicula['video_url'] ?? ''; // Valor predeterminado
              final title = pelicula['title'] ?? 'Sin título';
              final releaseDate = pelicula['release_date'] ?? 'Fecha desconocida';
              final posterPath = pelicula['poster_path'] ?? '';

              return ListTile(
                title: Text(title),
                subtitle: Text(releaseDate),
                leading: posterPath.isNotEmpty
                    ? Image.network(
                        'https://image.tmdb.org/t/p/w500$posterPath',
                        width: 50,
                      )
                    : Icon(Icons.image_not_supported),
                onTap: () {
                  if (videoUrl.isNotEmpty) {
                    Navigator.pushNamed(
                      context,
                      '/multimedia',
                      arguments: videoUrl,
                    );
                  } else {
                    // Mostrar un SnackBar si no hay video disponible
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No hay video disponible')),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
