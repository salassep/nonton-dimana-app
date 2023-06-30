import 'package:flutter/material.dart';
import 'package:nonton_dimana_app/controllers/home_controller.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController>{
  Home({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
return Scaffold(
      appBar: AppBar(
        title: Text('Form Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => homeController.movieTitle.value = value,
              controller: homeController.movieController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            Obx(() => Text(homeController.movieTitle.value)),
            ElevatedButton(
              onPressed: () => {},
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}