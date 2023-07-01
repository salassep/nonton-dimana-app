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
              onChanged: (value) => homeController.searchMovieByTitle(),
              controller: homeController.titleController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            Flexible(
              child: Container(
                color: Colors.red,
                child: Obx(() {

                  if (homeController.title.value == '') return SizedBox.shrink();

                  if (homeController.movies.isEmpty) return const Text("Film tidak ditemukan");
              
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: homeController.movies.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(homeController.movies[index]['title']),
                      );
                    },
                  );
                }),
              ),
            ),
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