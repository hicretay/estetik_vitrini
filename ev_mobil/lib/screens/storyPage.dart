import 'package:estetikvitrini/model/users.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/storyWidget.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
    static const route = "/storyPage";

  final User user;

  const StoryPage({
    @required this.user,
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

    final initialPage = users.indexOf(widget.user);
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
        children: users
            .map((user) => StoryWidget(
                  user: user,
                  controller: controller,
                ))
            .toList(),
      );
}
}