import 'dart:io';

import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';

class ExitAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Uygulamadan çıkılsın mı?"),
      actions: <Widget>[
        MaterialButton(
          color: primaryColor,
            onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text("Hayır",
            style: Theme.of(context).textTheme.button!.copyWith(
            fontWeight: FontWeight.normal,color: white),
          ),
        ),
        MaterialButton(
          color: primaryColor,
          onPressed: () {
            exit(0);
          },
          child: Text("Evet",
          style: Theme.of(context).textTheme.button!.copyWith(
          fontWeight: FontWeight.normal,color: white)),
        ),
      ],
    );
  }
}