import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DSCarousalWidget extends StatelessWidget {
  const DSCarousalWidget({
    required this.children,
    required this.height,
    this.viewportFraction = 1.0,
    this.enableInfiniteScroll = false,
    this.autoPlay = false,
    this.onPageChanged,
    this.scrollDirection = Axis.horizontal,
    this.scrollPhysics,
    super.key,
  });

  final List<Widget> children;
  final double height;
  final double viewportFraction;
  final bool enableInfiniteScroll;
  final bool autoPlay;
  final void Function(int index, CarouselPageChangedReason reason)?
  onPageChanged;
  final Axis scrollDirection;
  final ScrollPhysics? scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        viewportFraction: viewportFraction,
        enableInfiniteScroll: enableInfiniteScroll,
        autoPlay: autoPlay,
        autoPlayInterval: 3.seconds,
        autoPlayAnimationDuration: 800.milliseconds,
        enlargeCenterPage: true,
        onPageChanged: onPageChanged,
        scrollDirection: scrollDirection,
        scrollPhysics: scrollPhysics,
      ),
      items: children,
    );
  }
}
