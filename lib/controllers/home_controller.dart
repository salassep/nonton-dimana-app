import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nonton_dimana_app/services/api_service.dart';
import 'package:nonton_dimana_app/services/movie_service.dart';

class HomeController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  // final ApiService _apiService = ApiService();
  final MovieService _movieService = MovieService();

  RxList movies = [].obs;
  RxString title = ''.obs;

  void searchMovieByTitle() async {
    // final result = await _apiService.getMoviesByTitle(title, 'id');
    title.value = titleController.text;
    final result = _movieService.getMoviesByTitle(title.value);

    movies.value = result;
  }
}