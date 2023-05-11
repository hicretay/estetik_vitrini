import 'package:estetikvitrini/widgets/storyWidget.dart';
import 'package:flutter/material.dart';

class StoryPage extends StatefulWidget {
  static const route = "/storyPage";

  final List? company;
  final int? storyIndex;
  final int? lastCompId;


  const StoryPage({@required this.company, this.storyIndex, this.lastCompId});

  @override
  _StoryPageState createState() => _StoryPageState(storyIndex: storyIndex, lastCompId: lastCompId);
}

class _StoryPageState extends State<StoryPage> {
  PageController? controller;
  int? storyIndex;
  int? lastCompId;
  _StoryPageState({this.storyIndex, this.lastCompId});

  @override
  void initState() {
    super.initState();
    // ignore: unused_local_variable
    final initialPage = widget.company!.indexOf(widget.company);
    controller = PageController(initialPage: widget.storyIndex!);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    //SystemChrome.setEnabledSystemUIOverlays([]); // tam ekran
    return PageView( 
        controller: controller,
        children:  widget.company!.map((compData) => 
                  StoryWidget(
                  company: compData,
                  controller: controller!,
                  storyIndex: widget.storyIndex!,
                  lastCompId: lastCompId!,
                )).toList(),
      );
    }
  }


