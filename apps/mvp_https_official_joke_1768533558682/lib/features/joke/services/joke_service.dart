import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke_model.dart';

class JokeService {
  static const String _apiUrl =
      'https://official-joke-api.appspot.com/random_joke';

  static Future<Joke> fetchRandomJoke() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return Joke.fromJson(json);
      } else {
        throw Exception('Failed to load joke: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch joke: $e');
    }
  }
}
