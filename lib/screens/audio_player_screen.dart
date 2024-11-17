import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String audioUrl;
  final String imageUrl;

  AudioPlayerScreen({required this.audioUrl, required this.imageUrl});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isLoading = false;
  bool _isLiked = false;
  bool isMutted = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudioPlayer();
  }

  Future<void> _initAudioPlayer() async {
    try {
      setState(() {
        _isLoading = true;
      });

      await _audioPlayer.setUrl(widget.audioUrl);
      _audioPlayer.durationStream.listen((duration) {
        setState(() {
          _duration = duration ?? Duration.zero;
        });
      });

      _audioPlayer.positionStream.listen((position) {
        setState(() {
          _position = position;
        });
      });

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _onSliderChanged(double value) {
    final position = Duration(seconds: value.toInt());
    _audioPlayer.seek(position);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(widget.imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.4), BlendMode.darken)),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: _isLoading
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            "Inner Bhakti",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Prarthna Plans",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          Slider(
                            value: _position.inSeconds.toDouble(),
                            min: 0.0,
                            max: _duration.inSeconds.toDouble(),
                            onChanged: _onSliderChanged,
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // like button
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isLiked = !_isLiked;
                                  });
                                },
                                icon: Icon(
                                  _isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.white,
                                ),
                              ),

                              GestureDetector(
                                child: IconButton(
                                  onPressed: _playPause,
                                  icon: Icon(
                                    _isPlaying
                                        ? Icons.pause_circle_filled
                                        : Icons.play_circle_fill,
                                    size: 70,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              // mute button

                              IconButton(
                                onPressed: () {
                                  _audioPlayer.setVolume(isMutted ? 1 : 0);
                                  setState(() {
                                    isMutted = !isMutted;
                                  });
                                },
                                icon: Icon(
                                  isMutted ? Icons.volume_off : Icons.volume_up,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "${_position.toString().split('.').first} / ${_duration.toString().split('.').first}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
