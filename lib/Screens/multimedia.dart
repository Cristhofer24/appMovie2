import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Multimedia extends StatefulWidget {
  const Multimedia({super.key});

  @override
  _Pantalla2State createState() => _Pantalla2State();
}

class _Pantalla2State extends State<Multimedia> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  double _volume = 1.0;
  double _seekValue = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    final String videoUrl = ModalRoute.of(context)!.settings.arguments as String;
    
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
      })
      ..addListener(() {
        setState(() {
          _seekValue = _controller.value.position.inSeconds.toDouble();
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(234, 2, 4, 67),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 80, 155),
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
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          else
            const Center(child: CircularProgressIndicator()),

          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    _isPlaying ? _controller.pause() : _controller.play();
                    _isPlaying = !_isPlaying;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.volume_up),
                onPressed: () {
                  setState(() {
                    _volume = _volume == 1.0 ? 0.0 : 1.0;
                    _controller.setVolume(_volume);
                  });
                },
              ),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}