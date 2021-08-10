import 'package:estetikvitrini/model/story.dart';
import 'package:estetikvitrini/model/company.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/profileWidget.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryWidget extends StatefulWidget {
  final Company company;
  final PageController controller;

  const StoryWidget({
    @required this.company,
    @required this.controller,
  });

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  final storyItems = <StoryItem>[];
  StoryController controller;
  String date = '';

  void addStoryItems() {
    for (final story in widget.company.stories) {
      switch (story.mediaType) {
        case MediaType.image:
          storyItems.add(StoryItem.pageImage(
            url: story.url,
            controller: controller,
            caption: story.caption,
            duration: Duration(
              milliseconds: (story.duration * 1000).toInt(),
            ),
          ));
          break;
        case MediaType.text:
          storyItems.add(
            StoryItem.text(
              title: story.caption,
              backgroundColor: story.color,
              duration: Duration(
              milliseconds: (story.duration * 1000).toInt(),
              ),
            ),
          );
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();

    controller = StoryController();
    addStoryItems();
    date = widget.company.stories[0].date;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleCompleted() {
    widget.controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );

    final currentIndex = companies.indexOf(widget.company);
    final isLastPage = companies.length - 1 == currentIndex;
    
    if (isLastPage) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Material(
            type: MaterialType.transparency,
            child: StoryView(
              storyItems: storyItems,
              controller: controller,
              onComplete: handleCompleted,
              onVerticalSwipeComplete: (Direction direction) {
                if ((direction == Direction.down) || (direction == Direction.up)) {
                  Navigator.pop(context);
                }
              },
              onStoryShow: (storyItem) {
                final index = storyItems.indexOf(storyItem);
                if (index > 0) {
                  setState(() {
                    date = widget.company.stories[index].date;
                  });
                }
              },
            ),
          ),
          ProfileWidget(
            company: widget.company,
            date: date,
          ),
        ],
      );
}