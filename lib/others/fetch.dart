import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflix_copy/others/data_model.dart';

List<Movie> movieList = [];
Future<List<Movie>> fetchData() async {
  final response =
      await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
  var shows = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (Map<String, dynamic> index in shows) {
      movieList.add(Movie.fromJson(index));
    }
    return movieList;
  } else {
    throw Exception('Failed to load Movie');
  }
}
