import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nonton_dimana_app/services/api_service.dart';
// import 'package:nonton_dimana_app/services/movie_service.dart';

class HomeController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final ApiService _apiService = ApiService();
  // final MovieService _movieService = MovieService();
  final RxBool showResult = true.obs;

  RxBool get isActive {
    if (focusNode.hasFocus || titleController.text.isNotEmpty) {
      return true.obs;
    } 
    return false.obs;
  }

  Future<List> searchMovieByTitle(String value) async {
    final result = await _apiService.getMoviesByTitle(value, 'id');
    return result;
    
    // final result = _movieService.getMoviesByTitle(value);
    // return result;
  }

  String streamingPlatformToString(Map streamingPlatform) {
    if (streamingPlatform['id'] == null) {
      return 'Belum ada platform yang menayangkan film ini';
    }

    return streamingPlatform['id'].keys
      .map((platform) => '${platform[0].toUpperCase()}${platform.substring(1)}')
      .join(', ');
  }

  String genreToString(List genres) {
    if (genres.isEmpty) {
      return '-';
    }

    return genres.map((e) => e['name']).join(', ');
  }

  String durationToString(int value) {
    int h, m, s;

    s = value ~/ 3600;
    h = ((value - s * 3600)) ~/ 60;
    m = value - (s  * 3600) - (h * 60);

    return '${h}j ${m}m';
  }
}