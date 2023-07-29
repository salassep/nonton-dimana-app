import 'package:flutter/material.dart';
import 'package:nonton_dimana_app/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends GetView<HomeController>{
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Obx(() => Padding(
            padding: homeController.isActive.value || isKeyboardOpen
              ? const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0) 
              : const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: homeController.isActive.value || isKeyboardOpen
                ? MainAxisAlignment.start 
                : MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Image.asset(
                    'assets/images/logo-cut.png'
                  ),
                ),
                TypeAheadField(
                  animationStart: 0,
                  animationDuration: Duration.zero,
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: homeController.titleController,
                    focusNode: homeController.focusNode,
                    decoration: const InputDecoration(
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
                    if (value.isEmpty) {
                      return [];
                    }
                    return homeController.searchMovieByTitle(value);
                  },
                  itemBuilder: (BuildContext context, value) {
                    return Card(
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
                            placeholder: (context, url) {
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
                          const SizedBox(width: 15.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Judul: ${value['title']}',
                                  overflow: TextOverflow.fade,
                                ),
                                Text('Tahun: ${value['year']}'),
                              ],
                            ),
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
      ),
    );
  }
}