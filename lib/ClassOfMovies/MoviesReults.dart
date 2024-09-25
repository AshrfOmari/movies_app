import 'movie.dart';

class MoviesReults {

  final  List<Movie> results;

  MoviesReults({
    this.results,

  });

  factory MoviesReults.fromJson(Map<String, dynamic> json) {
    return MoviesReults(
      results: parseResults(json),
    );
  }
  static List<Movie> parseResults(resultjson) {
    var list = resultjson['results'] as List;
    List<Movie> obj = list.map((data) => Movie.fromJson(data)).toList();
    return obj;
  }
}
