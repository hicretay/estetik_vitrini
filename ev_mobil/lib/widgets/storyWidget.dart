import 'package:estetikvitrini/JsnClass/companyListJsn.dart';
import 'package:estetikvitrini/model/company.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:estetikvitrini/settings/functions.dart';

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

  List companyContent =[];

  Future companyList() async{
   final CompanyListJsn companyNewList = await companyListJsnFunc(); 
   setState(() {
      companyContent = companyNewList.result;
   });
 }

  void addStoryItems() {
    for (final story in widget.company.stories) {
        storyItems.add(StoryItem.pageImage(
        url: story.url,
        controller: controller,
        caption: story.caption,
        duration: Duration(
        milliseconds: (story.duration * 1000).toInt()),
      ));     
    }
  }

  @override
  void initState() {
    super.initState();
    controller = StoryController();
    companyList();
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
        //--------------------------------Profil görünümü------------------------------------
        Material(
        type: MaterialType.transparency,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: deviceWidth(context)*0.05, vertical: deviceHeight(context)*0.09),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(              
                radius: 26,
                child: Container(
                  child: companyContent.isEmpty ? 
                  CircularProgressIndicator():
                  Image.network(companyContent.first.companyLogo ?? " ",
                  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child; // fotoğraf yüklenirken circular döndürme
                      return Center(
                      child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null 
                      ?  loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                      : null,
                    ));
                  }),
                ),
              ),
              SizedBox(width: deviceWidth(context)*0.02),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: maxSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        companyContent.isEmpty ? "company" :
                        companyContent.first.companyName  , //companyContent companyName
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(date,style: TextStyle(color: Colors.white38))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}