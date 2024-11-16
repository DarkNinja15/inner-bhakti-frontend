import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/program_controller.dart';
import 'audio_player_screen.dart';

class ProgramDetailsScreen extends StatelessWidget {
  final ProgramController controller = Get.find();
  final String programId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.fetchProgramDetails(programId);
    return Scaffold(
      appBar: AppBar(title: Text('Program Details')),
      body: Obx(() {
        final program = controller.selectedProgram.value;
        if (program == null) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: program.tracks.length,
          itemBuilder: (context, index) {
            final track = program.tracks[index];
            return ListTile(
              title: Text(track.title),
              onTap: () {
                Get.to(() => AudioPlayerScreen(), arguments: track.audioUrl);
              },
            );
          },
        );
      }),
    );
  }
}
