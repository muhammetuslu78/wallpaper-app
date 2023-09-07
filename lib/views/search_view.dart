import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/components/gradient_background.dart';
import 'package:wallpaper_app/views/wallpaper_detail_view.dart';

import '../data/data.dart';
import '../model/category_view_model.dart';
import '../model/wallpaper_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  var filteredWallpaperUrl;
  var myWallpaper;
  var searchedQuery = 'sky';
  List<CategoriesViewModel>? categories;
  List<WallpaperModel> walls = [];
  List<String> myWallpapers = [];

  Future<void> getWallpaperUrl() async {
    filteredWallpaperUrl = await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$searchedQuery&per_page=16'),
        headers: {'Authorization': apiKey});

    var gifUrlParsed = jsonDecode(filteredWallpaperUrl.body);
    myWallpapers.clear();
    setState(() {
      myWallpaper = gifUrlParsed['photos'][1]['src']['portrait'];

      for (int i = 0; i < 16; i++) {
        myWallpapers.add(gifUrlParsed['photos'][i]['src']['portrait']);
      }
    });

    print(
        '*****************************************${myWallpapers[10]}****************************************************');
  }

  @override
  void initState() {
    getWallpaperUrl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return myWallpaper == null
        ? Center(child: SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.red : Colors.green,
                ),
              );
            },
          ))
        : Scaffold(
            body: SafeArea(
                child: GradientBackground(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  searchedQuery = 'sky';
                                } else {
                                  searchedQuery = value;
                                }
                              });
                            },
                            decoration: InputDecoration(
                                prefixIcon: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    getWallpaperUrl();
                                  },
                                  icon: Icon(Icons.search),
                                ),
                                hintText: 'Search',
                                hintStyle: TextStyle(color: Colors.white),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide:
                                        new BorderSide(color: Colors.orange))),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: GridView.builder(
                          itemCount: 16,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                WallpaperDetailView(
                                                    detailWallpaper:
                                                        myWallpapers[index])));
                                  },
                                  child: Container(
                                    child: myWallpapers[index] == null
                                        ? CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.green),
                                          )
                                        : Image.network(
                                            myWallpapers[index],
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            );
                          })),
                ],
              ),
            )),
          );
  }
}
