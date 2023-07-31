import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nonton_dimana_app/services/movie_service.dart';

class HomeController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  // final ApiService _apiService = ApiService();
  final MovieService _movieService = MovieService();
  final RxBool showResult = true.obs;

  // RxList movies = [].obs;

  RxBool get isActive {
    if (focusNode.hasFocus || titleController.text.isNotEmpty) {
      return true.obs;
    } 
    return false.obs;
  }

  List searchMovieByTitle(String value) {
    // final result = await _apiService.getMoviesByTitle(title, 'id');
    // title.value = titleController.text;
    // movies.value = result;
    
    final result = _movieService.getMoviesByTitle(value);
    return result;
  }
}