import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inner_bhakti_frontend/widgets/track_tile.dart';
import '../controllers/program_controller.dart';
import 'audio_player_screen.dart';

class ProgramDetailsScreen extends StatelessWidget {
  final ProgramController controller = Get.find();
  final String programId = Get.arguments;

  ProgramDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchProgramDetails(programId);
    return Scaffold(
      appBar: AppBar(title: const Text('Program Details')),
      body: Obx(() {
        final program = controller.selectedProgram.value;
        if (program == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(program.image),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        program.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        program.description,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: const Color.fromARGB(255, 29, 43, 67),
                    height: 50,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Available Tracks: ${program.tracks.length}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: program.tracks.length,
                      itemBuilder: (context, index) {
                        final track = program.tracks[index];
                        return TrackTile(
                          track: track,
                          imageUrl: program.image,
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
