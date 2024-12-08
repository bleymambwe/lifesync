import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:lifesync/Utils/theme.dart';

class PrescriptionDashboard extends StatelessWidget {
  const PrescriptionDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlurryContainer(
            blur: 15,
            elevation: 5,
            color: Colors.transparent.withGreen(50),
            padding: EdgeInsets.all(8),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Text(
              'Current Plan',
              style: AppTheme.subsubsubheadingtitle,
            )),
        BlurryContainer(
            blur: 15,
            elevation: 5,
            color: Colors.transparent.withGreen(50),
            // shadowColor: Colors.greenAccent.withOpacity(0.2),

            padding: EdgeInsets.all(8),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Text(
              'Optimise Cost',
              style: AppTheme.subsubsubheadingtitle,
            ))
      ],
    ));
  }
}
