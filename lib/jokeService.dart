import 'package:dio/dio.dart';

class JokeService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://v2.jokeapi.dev/joke';

  Future<List<Map<String, dynamic>>> fetchJokesRaw() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/Programming',
        queryParameters: {
          'amount': 3,
          'blackListFlags': 'nsfw,religious,political,racist,sexist,explicit',
        },
      );

      if (response.statusCode == 200) {
        if (response.data['error'] == true) {
          throw Exception(response.data['message'] ?? 'Failed to fetch jokes');
        }
        final List<dynamic> jokesJson = response.data['jokes'];
        return jokesJson.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load jokes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching jokes: $e');
    }
  }
}