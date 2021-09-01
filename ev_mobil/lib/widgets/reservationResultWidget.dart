import 'package:estetikvitrini/settings/consts.dart';
import 'package:flutter/material.dart';

class ResevationResultWidget extends StatelessWidget {
  final String companyName;
  final String operation;
  final String time;
  final String date;
  final VoidCallback onTap;

  const ResevationResultWidget({
    Key key, this.companyName, this.operation, this.time, this.date, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: defaultPadding),
            child: Align(
            alignment: Alignment.topLeft,
            child: Text(date,     
            style     : TextStyle(
            fontWeight: FontWeight.bold,
            color     : primaryColor),
          ),
        ),
      ),
        Container(
          color: lightWhite,
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
                          width: deviceWidth(context)*0.57,
                          child: Text(
                            companyName,
                            overflow: TextOverflow.fade,
                            softWrap: false,                          
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: minSpace),
                        Text(
                          operation,
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            time,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        SizedBox(width:deviceWidth(context)*0.05),
                        GestureDetector(
                          child: Icon(Icons.clear,size: 18),
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
