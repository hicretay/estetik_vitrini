import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../settings/consts.dart';

class LeadingRowWidget extends StatefulWidget {
  //homePage ve favoritePage sayfalarında kullanıldı
  final int iconNumber; // icon resmi indexi
  final VoidCallback onPressed; //more iconu olayı

  const LeadingRowWidget({Key key, this.iconNumber, this.onPressed})
      : super(key: key);

  @override
  _LeadingRowWidgetState createState() => _LeadingRowWidgetState();
}

class _LeadingRowWidgetState extends State<LeadingRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment
          .spaceAround, // Row içindeki widgetların yayılmasını sağlar
      children: [
        Row(
          children: [
            //------------Başlıktaki firma logosu görünümü-----------
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    users[widget.iconNumber].imgUrl, //stories listesinden icon indexi çekme
                  ),
                ),
              ),
            ),
            //-----------------------------------------------------
            SizedBox(width: 5), //başlık iconu - texti arası boşluk

            Text(
              //"Estecool Güzellik Merkezi" metni
              leading,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        IconButton(
          // daha fazla icon buttonu
          icon: Icon(FontAwesomeIcons.thumbtack,color: primaryColor,size: 20),
          onPressed: widget.onPressed, // olayı parametre alındı
        ),
      ],
    );
  }
}
