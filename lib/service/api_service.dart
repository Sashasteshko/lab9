import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  final Dio _dio = Dio();

  // !!! Вставте сюди ваш URL з RequestCatcher !!!
  final String _baseUrl = 'https://lab12.requestcatcher.com/test';

  // Метод для відправки запитів
  Future<void> postRequest(
      BuildContext context,
      String endpoint,
      Map<String, dynamic> data
      ) async {
    try {
      final response = await _dio.post('$_baseUrl/$endpoint', data: data);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Success: /$endpoint (Code: ${response.statusCode})'),
          backgroundColor: Colors.green,
        ),
      );
    } on DioException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}