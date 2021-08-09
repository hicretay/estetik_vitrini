import 'package:toast/toast.dart';


//------------------------------Toast Mesaj Gösterme Fonksiyonu-----------------------------------------
import 'package:flutter/material.dart';

showToast(BuildContext context, String content){
  return Toast.show(content, context, backgroundColor: Colors.grey,duration: 3, textColor: Colors.black,gravity: Toast.LENGTH_SHORT);
}
//------------------------------------------------------------------------------------------------------

