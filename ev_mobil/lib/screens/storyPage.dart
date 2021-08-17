import 'package:estetikvitrini/model/company.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/storyWidget.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
    static const route = "/storyPage";

  final Company company;

  const StoryPage({
    @required this.company,
    Key key,
  }) : super(key: key);

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  PageController controller;

  @override
  void initState() {
    super.initState();

    final initialPage = companies.indexOf(widget.company);
    controller = PageController(initialPage: initialPage);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    //SystemChrome.setEnabledSystemUIOverlays([]); // tam ekran
    return PageView( 
        controller: controller,
        children: companies.map((user) => StoryWidget(
                  company: user,
                  controller: controller,
                )).toList(),
      );
}
}