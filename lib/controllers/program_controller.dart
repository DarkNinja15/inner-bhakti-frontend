import 'package:get/get.dart';
import '../models/program.dart';
import '../services/api_service.dart';

class ProgramController extends GetxController {
  final ApiService _apiService = ApiService();

  var programs = <Program>[].obs;
  var selectedProgram = Rxn<Program>();

  @override
  void onInit() {
    fetchPrograms();
    super.onInit();
  }

  void fetchPrograms() async {
    programs.value = await _apiService.fetchPrograms();
  }

  void fetchProgramDetails(String id) async {
    selectedProgram.value = await _apiService.fetchProgramDetails(id);
  }
}
