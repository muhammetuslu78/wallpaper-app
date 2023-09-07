import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/components/gradient_background.dart';
import 'package:wallpaper_app/constants/text_style.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/category_view_model.dart';
import 'package:wallpaper_app/model/favourites_view_model.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/wallpaper_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool fav = false;
  IconData favIcon = Icons.favorite_border;
  var wallpaperUrl;
  var filteredWallpaperUrl;
  var myWallpaper;
  var categoryName = 'sky';
  String searchedQuery = 'sky';
  List<CategoriesViewModel>? categories;
  List<WallpaperModel> walls = [];
  List<FavViewModel> favs = [];
  List<String> myWallpapers = [];
  List<String> myFavourites = [];
  late FavViewModel favViewModel;

  Future<void> getWallpaperUrl() async {
    wallpaperUrl = await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?per_page=16&page=1'),
        headers: {'Authorization': apiKey});
    filteredWallpaperUrl = await http.get(
        Uri.parse(
            'https://api.pexels.com/v1/search?query=$categoryName&per_page=16'),
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

  addFav(String bookUrl) {
    if (favViewModel.favImageUrl.contains(bookUrl)) {
      setState(() {
        favIcon = Icons.favorite_border;
      });
    } else {
      favs.add(FavViewModel(favImageUrl: bookUrl));
      setState(() {
        favIcon = Icons.favorite;
      });
    }
  }

  @override
  void initState() {
    getWallpaperUrl();
    categories = getCategories();
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
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Wallpaper',
                style: TextStyle(fontSize: 32),
              ),
              backgroundColor: Color(0xff090979),
            ),
            body: Center(
                child: GradientBackground(
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories?.length ?? 8,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  categoryName =
                                      categories![index].categoryName;
                                  getWallpaperUrl();
                                });

                                //getWallpaperUrl(categoryName);
                                print(categoryName);
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(categories?[index]
                                            .imgUrl ??
                                        'https://c4.wallpaperflare.com/wallpaper/500/442/354/outrun-vaporwave-hd-wallpaper-preview.jpg'),
                                    // card yap bunu
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.black26,
                                    ),
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    alignment: Alignment.center,
                                    child: Text(
                                      categories?[index].categoryName ??
                                          'Default',
                                      style: textOfCategories,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  Expanded(
                      flex: 7,
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
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 250,
                                        width: 450,
                                        child: myWallpapers[index] == null
                                            ? CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Colors.green),
                                              )
                                            : Image.network(
                                                myWallpapers[index],
                                                fit: BoxFit.fill,
                                              ),
                                      ),
                                      Container(
                                        height: 250,
                                        width: 500,
                                        child: IconButton(
                                          alignment: Alignment.bottomRight,
                                          onPressed: () {
                                            addFav(myWallpapers[index]);
                                            print('clicked');
                                          },
                                          icon: Icon(favIcon),
                                        ),
                                      )
                                    ],
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

/*Widget wallpaperList({List<WallpaperModel>? wallpapers, context}) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: wallpapers.map((wallpaper) => return GridTile(child: Container(child: ClipRRect(borderRadius: BorderRadius.circular(16),child: Image.network(wallpaper.srcModel!.portrait)),))) ,
      ));
}*/
