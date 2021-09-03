import 'package:estetikvitrini/JsnClass/storyContentJsn.dart';
import 'package:estetikvitrini/widgets/storyWidget.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  static const route = "/storyPage";

  final List company;
  final StoryContentJsn storyContent;
  final int storyIndex;


  const StoryPage({@required this.company, @required this.storyContent, this.storyIndex});

  @override
  _StoryPageState createState() => _StoryPageState(storyContent: storyContent);
}

class _StoryPageState extends State<StoryPage> {
  PageController controller;
  StoryContentJsn storyContent;

  _StoryPageState({this.storyContent});

  @override
  void initState() {
    super.initState();
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
                  storyContent: storyContent,
                )).toList(),
      );
     }
   }


