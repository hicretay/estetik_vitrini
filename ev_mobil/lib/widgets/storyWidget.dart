import 'package:estetikvitrini/JsnClass/storyContentJsn.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/functions.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryWidget extends StatefulWidget {
  final dynamic company; //company list servisindeki id, companyName, companyLogo değişkenkleri
  final PageController controller;
  final int storyIndex; //company list servisindeki id değeri
  final StoryContentJsn storyContent; // storyContentJsn servisindeki id, storyContentPicture,  storyContent değişkenkleri 

  const StoryWidget({
    @required this.company,
    @required this.controller, this.storyIndex, this.storyContent,
  });

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  StoryController controller;
  int storyIndex;

  List storyContent = [];
  
  Future<List<StoryItem>> addStoryItems() async{ //storyItems listesine storyleri ekleyen fonk.
  List<StoryItem> storyItems = [];
  StoryContentJsn temp = await storyContentJsnFunc(widget.company.id);
  List<dynamic>storyContent = temp.result; 
    for (final itemS in storyContent) {
        storyItems.add(StoryItem.pageImage(
        url: itemS.storyContentPicture,
        controller: controller,
        caption: itemS.storyContent,
        duration: Duration(milliseconds: 3000),
      ));
    }
    return storyItems;
  }

  @override
  void initState() {
    super.initState();
    this.storyIndex = widget.storyIndex;
    controller = StoryController();
    addStoryItems();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleCompleted() { // Story tamamlandığında olacakların fonk.
    widget.controller.nextPage( // sonraki sayfa animasyonu
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    final currentIndex = storyContent.indexOf(storyContent[storyIndex]);
    final isLastPage = storyContent.length  == currentIndex;   
    if (isLastPage) {
      Navigator.of(context).pop();
    } 
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
          future: addStoryItems(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Hata oluştu"),);
            }else if (snapshot.hasData) {
              List<StoryItem> storyItems = snapshot.data;
            return Stack(
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
                      circularBasic :
                      Image.network(widget.company.companyLogo ?? " ",
                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child; // fotoğraf yüklenirken circular döndürme
                          return Center(
                          child: CircularProgressIndicator(
                          backgroundColor: primaryColor,valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
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
            }else {
              return circularBasic;
            }
            
          }
        );}
}