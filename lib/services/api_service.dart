import 'package:dio/dio.dart';
import '../models/program.dart';

class ApiService {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://inner-bhakti-backend.onrender.com/'));

  Future<List<Program>> fetchPrograms() async {
    final response = await _dio.get('/programs');
    return (response.data as List)
        .map((json) => Program.fromJson(json))
        .toList();
  }

  Future<Program> fetchProgramDetails(String id) async {
    final response = await _dio.get('/programs/$id');
    return Program.fromJson(response.data);
  }
}
