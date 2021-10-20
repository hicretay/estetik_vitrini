import 'package:estetikvitrini/providers/themeDataProvider.dart';
import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResevationResultWidget extends StatelessWidget {
  final String companyName;
  final String operation;
  final String time;
  final String date;
  final Widget confirmButton;
  final VoidCallback onTap;

  const ResevationResultWidget({
    Key key, this.companyName, this.operation, this.time, this.date, this.onTap, this.confirmButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Provider.of<ThemeDataProvider>(context, listen: true).isLightTheme ? lightWhite : darkBg,
          width: double.infinity,
          child: Padding(
            padding:  EdgeInsets.all(defaultPadding),
            child: Column(
            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: deviceWidth(context)*0.5,
                          child: Text(
                            companyName,
                            overflow: TextOverflow.fade,
                            softWrap: false,                          
                            style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).hintColor),
                          ),
                        ),
                        SizedBox(height: minSpace),
                        SizedBox(
                          width: deviceWidth(context)*0.5,
                          child: Text(
                            operation,
                            overflow: TextOverflow.fade,
                            style: TextStyle(fontSize: 16,color: Theme.of(context).hintColor),
                            textAlign: TextAlign.left,                         
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            time,
                            style: TextStyle(fontSize: 16,color: Theme.of(context).hintColor),
                          ),
                        ),
                        SizedBox(width:deviceWidth(context)*0.05),
                        confirmButton,
                        SizedBox(width:deviceWidth(context)*0.05),
                        GestureDetector(
                          child: Icon(Icons.clear,size: 18,color: Theme.of(context).hintColor),
                          onTap: onTap,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: defaultPadding),
      ],
    );
  }
}
