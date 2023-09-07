import 'package:flutter/material.dart';

class DetailIcon extends StatelessWidget {
  const DetailIcon(
      {Key? key,
      required this.detailWallpaper,
      required this.onPress,
      required this.icon})
      : super(key: key);

  final String? detailWallpaper;
  final VoidCallback onPress;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
        onPressed: onPress);
  }
}
