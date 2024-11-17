import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inner_bhakti_frontend/widgets/program_card.dart';
import '../controllers/program_controller.dart';

class ProgramListScreen extends StatelessWidget {
  final ProgramController controller = Get.put(ProgramController());

  ProgramListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (controller.programs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.yellow.withOpacity(0.2),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0],
            )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Inner Bhakti',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          controller.fetchPrograms();
                        },
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                  const Text(
                    "Prarthna Plans",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: controller.programs.length,
                      itemBuilder: (context, index) {
                        final program = controller.programs[index];
                        return ProgramCard(program: program);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
