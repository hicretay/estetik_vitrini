import 'package:estetikvitrini/model/story.dart';
import 'package:flutter/material.dart';

class User {
  final String name;
  final String imgUrl;
  final List<Story> stories;

  const User({
    @required this.name,
    @required this.imgUrl,
    @required this.stories,
  });
}