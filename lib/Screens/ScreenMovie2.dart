import 'package:flutter/material.dart';
import 'package:movie_app2/Screens/trailerScreen.dart';
import 'package:movie_app2/service/movieApiService.dart';

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
              return ListTile(
                title: Text(pelicula['title']),
                subtitle: Text(pelicula['release_date']),
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w500${pelicula['poster_path']}',
                  width: 50,
                ),
                onTap: () {
                  // Navegar a la pantalla del trailer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrailerScreen(
                        movieId: pelicula['id'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}