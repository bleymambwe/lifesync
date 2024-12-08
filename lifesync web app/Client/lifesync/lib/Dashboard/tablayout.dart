import 'package:flutter/material.dart';
import 'package:lifesync/Utils/theme.dart';

class TabLayout extends StatelessWidget {
  const TabLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GContainer(
          child: Container(
              // width: 80,
              //height: 30,
              child: Text(
            'Home',
            style: AppTheme.subsubheadingtitle,
          )),
        ),
        GContainer(
          child: Container(
              //width: 130,
              // height: 30,
              child: Text(
            'Prescription',
            style: AppTheme.subsubheadingtitle,
          )),
        ),
        GContainer(
          child: Container(
              //width: 70,
              // height: 30,
              child: Text(
            'Diet',
            style: AppTheme.subsubheadingtitle,
          )),
        ),
        GContainer(
          child: Container(
              // width: 60,
              //height: 30,
              child: Text(
            ' Fitness',
            style: AppTheme.subsubheadingtitle,
          )),
        )
      ],
    );
  }
}
