import 'package:flutter/material.dart';
import 'package:wallpaper_app/views/search_view.dart';

import 'favourites_view.dart';
import 'home_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> _myWidgets = [HomeView(), SearchView(), FavView()];
  int _myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _myWidgets[_myIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType
                .shifting, //Basınca farklı renkte bottom tabların gelmesi için
            onTap: (value) {
              setState(() {
                _myIndex = value;
              });
            },
            currentIndex: _myIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.lightBlueAccent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                  backgroundColor: Colors.lightBlueAccent),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favourites',
                  backgroundColor: Colors.lightBlueAccent)
            ]));
  }
}
