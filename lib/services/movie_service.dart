import 'data/movies.dart';

class MovieService {

  final List _movies = data;

  List<Map<String, dynamic>> getMoviesByTitle(String title) {
    List<Map<String, dynamic>> foundMovies = [];

    for (var movie in _movies) {
      String fullTitle = movie['title'].toLowerCase();
      if (fullTitle.contains(title.toLowerCase())) {
        foundMovies.add(movie);
      }
    }

    return foundMovies;
  }
}
