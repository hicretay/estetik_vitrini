import 'package:flutter/material.dart';

class Story {
  final String url;
  final double duration;
  final String caption;
  final String date;
  final Color color;

  Story({
    @required this.caption,
    @required this.date,
    this.url,
    this.duration = 5.0,
    this.color = Colors.grey,
  });
}