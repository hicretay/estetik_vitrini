import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
 static const route = "settingsPage";

  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundContainer(
        colors: backGroundColor1,
      ),
    );
  }
}
