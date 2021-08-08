import 'package:estetikvitrini/model/users.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final User user;
  final String date;

  const ProfileWidget({
    @required this.user,
    @required this.date,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        type: MaterialType.transparency,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: deviceWidth(context)*0.05, vertical: deviceHeight(context)*0.09),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage(user.imgUrl),
              ),
              SizedBox(width: deviceWidth(context)*0.02),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: maxSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(date,style: TextStyle(color: Colors.white38))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
}