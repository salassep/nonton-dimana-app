import 'package:flutter/material.dart';
import 'package:nonton_dimana_app/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends GetView<HomeController>{
  Home({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: screenHeight / 6, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset(
                  'assets/images/logo-cut.png'
                ),
              ),
              const SizedBox(height: 10.0),
              TypeAheadField(
                animationStart: 0,
                animationDuration: Duration.zero,
                textFieldConfiguration: const TextFieldConfiguration(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Apa judul filmnya ?',
                    prefixIcon: Icon(Icons.search),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFB3005E))
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    )
                  )
                ),
                hideSuggestionsOnKeyboardHide: false,
                suggestionsCallback: (value) {
                  if (value.isEmpty) return [];
                  return homeController.searchMovieByTitle(value);
                },
                itemBuilder: (context, value) {
                  return Card(
                    color: const Color(0xFFB3005E),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: value['poster'],
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: 140,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                )
                              ),
                            );
                          },
                          placeholder: (coantext, url) {
                            return Container(
                              width: 140,
                              height: 200,
                              color: Colors.grey,
                              child: Image.asset(
                                'assets/images/logo-no-word.png'
                              ),
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Container(
                              width: 140,
                              height: 200,
                              color: Colors.grey,
                              child: Image.asset(
                                'assets/images/logo-no-word.png'
                              ),
                            );
                          }
                        ),
                        SizedBox(width: 15.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Judul: ${value['title']}'),
                            Text('Tahun: ${value['year']}'),
                          ],
                        ),
                      ],
                    )
                  );
                }, 
                onSuggestionSelected: (suggestion) {
                  print(suggestion);
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}