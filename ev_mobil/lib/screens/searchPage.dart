import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController teSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
        color: secondaryColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
              controller: teSearch,
               decoration: InputDecoration(
                 suffixIcon: FaIcon(FontAwesomeIcons.search,color: Theme.of(context).hintColor,size: 25,textDirection: TextDirection.ltr), 
                 contentPadding: EdgeInsets.all(maxSpace),
                 filled: true,
                 fillColor: Colors.white,
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(cardCurved),
                 ),
               ),
           ),
            ),
          ],
        ),
      )),
    );
  }
}