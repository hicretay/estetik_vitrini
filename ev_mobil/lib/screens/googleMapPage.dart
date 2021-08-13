import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  GoogleMapPage({Key key}) : super(key: key);

  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children:[
              Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                children: [
                  CircleAvatar(
                    //iconun çevresini saran yapı tasarımı
                    maxRadius: 25,
                    backgroundColor: secondaryColor,
                    child: IconButton(
                      iconSize: iconSize,
                      icon: Icon(Icons.arrow_back,color: primaryColor,size: 25),
                      onPressed: (){Navigator.pop(context, false);},
                    ),
                  ),
                  SizedBox(width: maxSpace),
                  Text("Estetik Vitrini",
                    
                    style     : TextStyle(
                    fontFamily: leadingFont, fontSize: 25, color:primaryColor),
                  ),
                ],
              )
            ),
            Expanded(
              child: WebView(
              initialUrl: "https://www.google.com/maps/place/Ae+Kod+Teknolojisi+%7C+Ae+Yaz%C4%B1l%C4%B1m/@38.001501,32.5057963,17z/data=!4m12!1m6!3m5!1s0x14d08dbd0918cb95:0xe7f4036c3d2c5cff!2sAe+Kod+Teknolojisi+%7C+Ae+Yaz%C4%B1l%C4%B1m!8m2!3d38.001501!4d32.507985!3m4!1s0x14d08dbd0918cb95:0xe7f4036c3d2c5cff!8m2!3d38.001501!4d32.507985",
              javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}