import 'package:flutter/material.dart';
import 'package:lifesync/Utils/theme.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:lifesync/Dashboard/dashboard.dart';
import 'onboardingcarousel.dart';
import 'package:lifesync/Utils/custom_transition.dart';

class onboardFour extends StatelessWidget {
  const onboardFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Center(
        //   child: Container(
        //     color: Colors.grey,
        //   ),
        // ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Snap a photo of your meal to check if it\'s safe for you ',
              textAlign: TextAlign.center,
              style: AppTheme.heading,
            ),
            Image.asset('assets/onboardfour.jpg'),

            // Image.network(
            //     'https://firebasestorage.googleapis.com/v0/b/lifesync-ai.firebasestorage.app/o/onboard%20image%20one.jpg?alt=media&token=a756055e-9df8-47f9-a971-c84289d1410d'),
          ],
        ),
      ],
    );
  }
}
