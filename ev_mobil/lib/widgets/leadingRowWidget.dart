import 'package:flutter/material.dart';

import '../settings/consts.dart';

class LeadingRowWidget extends StatelessWidget {
  //homePage ve favoritePage sayfalarında kullanıldı
  final int iconNumber; // icon resmi indexi
  final VoidCallback onPressed; //more iconu olayı

  const LeadingRowWidget({Key key, this.iconNumber, this.onPressed})
      : super(key: key);

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
                    stories[iconNumber]
                        ["icon"], //stories listesinden icon indexi çekme
                  ),
                ),
              ),
            ),
            //-----------------------------------------------------
            SizedBox(width: 5),//başlık iconu - texti arası boşluk

            Text(
              //"Estecool Güzellik Merkezi" metni
              leading,
              style: TextStyle(fontSize: 19),
            ),
          ],
        ),
        IconButton(// daha fazla icon buttonu
          icon: Icon(
            Icons.more_horiz,
          ),
          onPressed: onPressed, // olayı parametre alındı
        ),
      ],
    );
  }
}
