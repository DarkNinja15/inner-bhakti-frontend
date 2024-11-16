import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/program_controller.dart';
import 'program_details_screen.dart';

class ProgramListScreen extends StatelessWidget {
  final ProgramController controller = Get.put(ProgramController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Programs')),
      body: Obx(() {
        if (controller.programs.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.programs.length,
          itemBuilder: (context, index) {
            final program = controller.programs[index];
            return ListTile(
              title: Text(program.name),
              subtitle: Text(program.description),
              onTap: () {
                Get.to(() => ProgramDetailsScreen(), arguments: program.id);
              },
            );
          },
        );
      }),
    );
  }
}
