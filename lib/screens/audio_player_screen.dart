import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerScreen extends StatefulWidget {
  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final String audioUrl = Get.arguments;
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _player.setUrl(audioUrl);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Audio Player')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<PlayerState>(
            stream: _player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              if (playerState?.playing == true) {
                return IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: () => _player.pause(),
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () => _player.play(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
