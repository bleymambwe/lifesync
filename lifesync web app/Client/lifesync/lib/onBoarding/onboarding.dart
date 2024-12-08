library mylibrary;

import 'package:flutter/material.dart';
import 'package:lifesync/Utils/theme.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:lifesync/Dashboard/dashboard.dart';
import 'onboardingcarousel.dart';
import 'package:lifesync/Utils/custom_transition.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.mainColor, AppTheme.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // color: Colors.yellowAccent,
          child: const Center(
            child: OnboardingCarousel(width: 500, height: 600, slides: [
              onboardOne(),
              onboardTwo(),
              onboardThree(),
              onboardFour(),
            ]),
          )),
    );
  }
}

class onboardOne extends StatelessWidget {
  const onboardOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            ' Tired of Guessing Your Way to Health?',
            textAlign: TextAlign.center,
            style: AppTheme.heading,
          ),
          Image.asset('assets/onboard_image_one.jpg'),
          // Image.network(
          //     'https://firebasestorage.googleapis.com/v0/b/lifesync-ai.firebasestorage.app/o/onboard%20image%20one.jpg?alt=media&token=a756055e-9df8-47f9-a971-c84289d1410d'),
        ],
      ),
    );
  }
}

class onboardTwo extends StatelessWidget {
  const onboardTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text(
          ' Input your Personal Informaition, underlying condition  & Prescrition, ',
          textAlign: TextAlign.center,
          style: AppTheme.heading,
        ),
        Image.asset('assets/onboard_image_one.jpg'),
        // Image.network(
        //     'https://firebasestorage.googleapis.com/v0/b/lifesync-ai.firebasestorage.app/o/onboard%20image%20one.jpg?alt=media&token=a756055e-9df8-47f9-a971-c84289d1410d'),
      ],
    );
  }
}

class onboardThree extends StatefulWidget {
  const onboardThree({super.key});

  @override
  State<onboardThree> createState() => _onboardThreeState();
}

class _onboardThreeState extends State<onboardThree> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      // Wrap Column with SingleChildScrollView
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            ' Get Personalised Fitness Exercises and Diet to match your condition, ',
            textAlign: TextAlign.center,
            style: AppTheme.heading,
          ),
          // Wrapping the Lottie widget inside an Expanded widget
          // Expanded(
          //   child: SizedBox(
          //     height: 10,
          //     width: 10,
          //     child: Center(
          //       child: Lottie.asset('assets/pushup.lottie'),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

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
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    CustomPageRoute(
                      page: const DashboardPage(),
                      transitionType: TransitionType
                          .fade, // You can also use slide, scale, or rotate
                    ),
                  );
                },
                child: const BlurryContainer(
                  blur: 15,
                  elevation: 5,
                  color: Colors.transparent,
                  padding: EdgeInsets.all(8),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Text(
                    'Get Started',
                    style: AppTheme.bodyText,
                  ),
                ),
              ),
            ),
            // Image.network(
            //     'https://firebasestorage.googleapis.com/v0/b/lifesync-ai.firebasestorage.app/o/onboard%20image%20one.jpg?alt=media&token=a756055e-9df8-47f9-a971-c84289d1410d'),
          ],
        ),
      ],
    );
  }
}
