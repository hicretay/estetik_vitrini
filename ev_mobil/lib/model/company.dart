import 'package:estetikvitrini/model/story.dart';
import 'package:flutter/material.dart';

class Company {
  final String name;
  final String imgUrl;
  final List<Story> stories;

  const Company({
    @required this.name,
    @required this.imgUrl,
    @required this.stories,
  });
}