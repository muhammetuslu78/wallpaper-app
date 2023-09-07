import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  GradientBackground({required this.child, this.padding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff090979), Color(0xff00d4ff)])),
      child: this.child,
    );
  }
}
