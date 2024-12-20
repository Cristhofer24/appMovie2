import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Multimedia extends StatefulWidget {
  const Multimedia({super.key});

  @override
  State<Multimedia> createState() => _MultimediaState();
}

class _MultimediaState extends State<Multimedia> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  double _volume = 1.0;
  double _seekValue = 0.0;
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final videoUrl = ModalRoute.of(context)!.settings.arguments as String;
    if (!_isInitialized) {
      _controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {
            _isInitialized = true;
          });
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No se pudo cargar el video")),
          );
        });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.red),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Reproductor de Video'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          else
            const Center(child: CircularProgressIndicator(color: Colors.red)),

          const SizedBox(height: 20),

          // Controles del reproductor
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildButton(
                icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                onPressed: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                      _isPlaying = false;
                    } else {
                      _controller.play();
                      _isPlaying = true;
                    }
                  });
                },
              ),
              buildButton(
                icon: Icons.stop,
                onPressed: () {
                  setState(() {
                    _controller.pause();
                    _controller.seekTo(const Duration(seconds: 0));
                    _isPlaying = false;
                  });
                },
              ),
              buildButton(
                icon: Icons.replay_10,
                onPressed: () {
                  setState(() {
                    final position = _controller.value.position;
                    _controller.seekTo(position - const Duration(seconds: 10));
                  });
                },
              ),
              buildButton(
                icon: Icons.forward_10,
                onPressed: () {
                  setState(() {
                    final position = _controller.value.position;
                    _controller.seekTo(position + const Duration(seconds: 10));
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Control de volumen
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Volumen', style: TextStyle(color: Colors.white)),
              Slider(
                value: _volume,
                min: 0.0,
                max: 1.0,
                onChanged: (value) {
                  setState(() {
                    _volume = value;
                    _controller.setVolume(_volume);
                  });
                },
                activeColor: Colors.red,
                inactiveColor: Colors.white.withOpacity(0.5),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Barra de progreso
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Progreso', style: TextStyle(color: Colors.white)),
              Slider(
                value: _seekValue,
                min: 0.0,
                max: _controller.value.duration.inSeconds.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _seekValue = value;
                    _controller.seekTo(Duration(seconds: value.toInt()));
                  });
                },
                activeColor: Colors.red,
                inactiveColor: Colors.white.withOpacity(0.5),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
