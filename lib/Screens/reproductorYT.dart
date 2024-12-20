import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // Inicializamos el controlador del video
    _controller = VideoPlayerController.network(widget.videoUrl);
    // Esperamos a que el controlador se inicialice
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reproductor de Video')),
      body: FutureBuilder<void>(
        future: _initializeVideoPlayerFuture, // Esperamos a que el controlador se inicialice
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mientras se inicializa el controlador, mostramos un círculo de carga
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Si ocurrió un error al inicializar el controlador, mostramos un mensaje
            return Center(child: Text('Error al cargar el video'));
          } else {
            // Si la inicialización se completó correctamente, mostramos el video
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Verificamos si el controlador está listo antes de intentar reproducir o pausar
          if (_controller.value.isInitialized) {
            setState(() {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
              }
            });
          } else {
            // Si no está listo, mostramos un mensaje o no hacemos nada
            print("El controlador no está listo para reproducciones");
          }
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // Al cerrar la pantalla, liberamos el controlador
    _controller.dispose();
  }
}
