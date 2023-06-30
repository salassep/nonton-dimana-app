import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final TextEditingController movieController = TextEditingController();

  RxString movieTitle = ''.obs;

  void submitTitle() {
    movieTitle.value = movieController.text;

    movieController.clear();
  }
}