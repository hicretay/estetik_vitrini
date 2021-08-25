import 'package:estetikvitrini/JsnClass/storyContentJsn.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:estetikvitrini/settings/functions.dart';

class StoryWidget extends StatefulWidget {
  final dynamic company; //silinecek
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
  String date = "";
  int storyIndex = 0;

  List storyContent = [];

   Future storyContentList() async{
   final StoryContentJsn storyContentNewList = await storyContentJsnFunc(widget.company.id); 
   setState(() {
      storyContent = storyContentNewList.result;
   });
 }

  Future addStoryItems() async{
    await storyContentList();
    for (final story in storyContent) {
        storyItems.add(StoryItem.pageImage(
        url: story.storyContentPicture,
        controller: controller,
        caption: story.storyContent,
        duration: Duration(milliseconds: 5000),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    controller = StoryController();
    addStoryItems();
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
    final currentIndex = storyContent.indexOf(storyContent[storyIndex]);
    final isLastPage = storyContent.length - 1 == currentIndex;   
    if (isLastPage) {
      Navigator.of(context).pop();
    }else{
    storyIndex++;
    }    
  }

  @override
  Widget build(BuildContext context) => 
  storyItems.isEmpty ? Center(child: CircularProgressIndicator(backgroundColor: primaryColor,valueColor: AlwaysStoppedAnimation<Color>(Colors.white),)):
        Stack(
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
                    date = date;
                  });
                }
              },
            ),
          ),
        //--------------------------------Profil görünümü------------------------------------
        Material(
        type: MaterialType.transparency,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: deviceWidth(context)*0.05, vertical: deviceHeight(context)*0.1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(  
                backgroundColor: white,            
                radius: 26,
                child: Container(
                  child: widget.company.companyLogo.isEmpty ?
                  CircularProgressIndicator():
                  Image.network(widget.company.companyLogo ?? " ",
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
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          widget.company.companyName.isEmpty ? "company" :
                          widget.company.companyName  , 
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
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