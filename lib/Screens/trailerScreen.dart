import 'package:flutter/material.dart';
import 'package:movie_app2/service/movieApiService2.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerScreen extends StatefulWidget {
  final int movieId;

  TrailerScreen({required this.movieId});

  @override
  _TrailerScreenState createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  late YoutubePlayerController _controller;
  late Future<String?> _trailerUrl;

  @override
  void initState() {
    super.initState();
    _trailerUrl = TMDBService2().obtenerTrailerPelicula(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trailer de la Película'),
      ),
      body: FutureBuilder<String?>(
        future: _trailerUrl,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text('No se pudo cargar el trailer'));
          } else {
            final trailerUrl = snapshot.data!;
            _controller = YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(trailerUrl)!,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            );

            return YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}