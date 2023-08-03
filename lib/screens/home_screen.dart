import 'package:flutter/material.dart';
import 'package:nonton_dimana_app/constants/app_color.dart';
import 'package:nonton_dimana_app/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:nonton_dimana_app/widgets/cache_network_image.dart';

class Home extends GetView<HomeController>{
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    Future<void> showDetailMovieDialog(BuildContext context, Map movie) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: Container(
              margin: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                color: AppColor.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0, right: 2.0),
                      child: GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: const Icon(
                          Icons.clear,
                          size: 40.0,
                        ),
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        movie['title'],
                        style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          cacheImage(
                            imageUrl: 'https://image.tmdb.org/t/p/w342${movie['posterPath']}', 
                            placeHolderImageUrl: 'assets/images/logo-no-word.png', 
                            width: MediaQuery.of(context).size.width / 1.2 , 
                            height: (MediaQuery.of(context).size.width / 1.2) + 100,
                            borderRadius: 10.0
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                '${movie['imdbRating']} ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0
                                ),
                              ),
                              const Icon(
                                Icons.star,
                                size: 20.0,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                          Text(
                            'Tahun: ${movie['year']}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ), 
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      );

      Future.delayed(const Duration(milliseconds: 100), () {
        homeController.showResult.value = true;
      });
      
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Obx(() => Padding(
            padding: homeController.isActive.value || isKeyboardOpen
              ? const EdgeInsets.only(left: 20.0, right: 20.0, top: 100.0) 
              : const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: homeController.isActive.value || isKeyboardOpen
                ? MainAxisAlignment.start 
                : MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 20.0),
                  child: Image.asset(
                    'assets/images/logo-cut.png'
                  ),
                ),
                TypeAheadField(
                  animationStart: 0,
                  animationDuration: Duration.zero,
                  keepSuggestionsOnSuggestionSelected: true,
                  keepSuggestionsOnLoading: false,
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: homeController.titleController,
                    focusNode: homeController.focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Apa judul filmnya ?',
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      )
                    )
                  ),
                  debounceDuration: const Duration(seconds: 1),
                  hideSuggestionsOnKeyboardHide: false,
                  suggestionsCallback: (value) async {
                    if (value.isEmpty) {
                      return [];
                    } 
                    final List movies = await homeController.searchMovieByTitle(value);
                    return movies;
                  },
                  itemBuilder: (BuildContext context, value) {
                    return Obx(() => Visibility(
                        visible: homeController.showResult.value,
                        child: Card(
                        color: AppColor.primaryColor,
                          child: Row(
                            children: [
                              cacheImage(
                                width: 100.0,
                                height: 160.0,
                                imageUrl: 'https://image.tmdb.org/t/p/w342${value['posterPath']}', 
                                placeHolderImageUrl: 'assets/images/logo-no-word.png'
                              ),
                              const SizedBox(width: 15.0),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${value['title']}',
                                        style: const TextStyle(
                                          color: AppColor.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0
                                        ),
                                      ),
                                      Text(
                                        '${value['year']}',
                                        style: const TextStyle(
                                          color: AppColor.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${value['imdbRating']}',
                                            style: const TextStyle(
                                              color: AppColor.secondaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0
                                            ),
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 14.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        )
                      )
                    );
                  },
                  noItemsFoundBuilder: (BuildContext context) {
                    return Container(
                      color: AppColor.primaryColor,
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Film tidak ditemukan.',
                        textAlign: TextAlign.center,
                       style: TextStyle(
                          color: AppColor.secondaryColor,
                          fontSize: 16.0
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (value) {
                    homeController.showResult.value = false;
                    homeController.focusNode.unfocus();
                    showDetailMovieDialog(context, value);
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