import 'package:estetikvitrini/widgets/storyWidget.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  static const route = "/storyPage";

  final List company;
  final int storyIndex;


  const StoryPage({@required this.company, this.storyIndex});

  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  PageController controller;

  @override
  void initState() {
    super.initState();
    // ignore: unused_local_variable
    final initialPage = widget.company.indexOf(widget.company);
    controller = PageController(initialPage: widget.storyIndex);
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
        children:  widget.company.map((compData) => 
                  StoryWidget(
                  company: compData,
                  controller: controller,
                  storyIndex: widget.storyIndex,
                )).toList(),
      );
    }
  }


