import 'package:estetikvitrini/settings/consts.dart';
import 'package:estetikvitrini/settings/googleSignInProvider.dart';
import 'package:estetikvitrini/widgets/backgroundContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
 static const route = "settingsPage";

  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BackGroundContainer(
          colors: backGroundColor1,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Text("Profil",style: Theme.of(context)
                     .textTheme
                     .headline4
                     .copyWith(color: primaryColor, fontFamily: leadingFont),),
            ),
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.photoURL),
              ),
            ),
            SizedBox(height: maxSpace),
            Text(user.displayName),
            Text(user.email),
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding,bottom: defaultPadding),
              child: ListTile(title: Text("Uygulamadan çıkış yap"),
              trailing: Icon(Icons.exit_to_app,color: primaryColor),
              tileColor: secondaryColor,
              dense: false,
              onTap: (){
                final provider = Provider.of<GoogleSignInProvider>(context,listen: false);
                provider.logout();
              }),
            )

          ],
          ),
        ),
      ),
    );
  }
}
