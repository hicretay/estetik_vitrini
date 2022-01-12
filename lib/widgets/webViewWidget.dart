import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String? locationUrl;
  WebViewWidget({Key? key, this.locationUrl}) : super(key: key);

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
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
                    maxRadius: 20,
                    backgroundColor: secondaryColor,
                    child: IconButton(
                      iconSize: iconSize,
                      icon: Icon(Icons.arrow_back,color: primaryColor,size: 25),
                      onPressed: (){Navigator.pop(context);},
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
              initialUrl: widget.locationUrl,
              javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}