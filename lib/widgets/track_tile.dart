import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inner_bhakti_frontend/models/program.dart';
import 'package:inner_bhakti_frontend/screens/audio_player_screen.dart';

class TrackTile extends StatelessWidget {
  const TrackTile({super.key, required this.track, required this.imageUrl});

  final Track track;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black87,
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        title: Text(
          track.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: const Text(
          '20 Days Plan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            // Play the track
            Get.to(() => AudioPlayerScreen(
                  audioUrl: track.audioUrl,
                  imageUrl: imageUrl,
                ));
          },
          child: const Icon(
            Icons.play_circle_fill,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
