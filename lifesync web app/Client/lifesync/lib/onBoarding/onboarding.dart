library mylibrary;

import 'package:flutter/material.dart';
import 'package:lifesync/Utils/theme.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:lifesync/Dashboard/dashboard.dart';
import 'onboardingcarousel.dart';
import 'package:lifesync/Utils/custom_transition.dart';
import 'onboardfour.dart';
import 'onboardfinal.dart';

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
            child: OnboardingCarousel(width: 700, height: 600, slides: [
              OnboardProblemStatement(),
              onboardOne(),
              onboardCall(),
              onboardFour(),
              onboardLoka(),
              OnboardFinal()
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
        ],
      ),
    );
  }
}

class onboardCall extends StatelessWidget {
  const onboardCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              ' LifeSync AI will call you for remind you to take your medicine or for general advice?',
              textAlign: TextAlign.center,
              style: AppTheme.heading,
            ),
            Image.asset('assets/onboardfour.jpg'),
          ]),
    );
  }
}

class onboardProblem extends StatelessWidget {
  const onboardProblem({super.key});

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
        //Image.asset('assets/onboard_image_one.jpg'),
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

class onboardLoka extends StatelessWidget {
  const onboardLoka({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Insights from the Lokahi Hackathon Dataset representing data in the healthcare',
          textAlign: TextAlign.center,
          style: AppTheme.heading,
        ),
        Column(
          children: [
            Row(
              children: [
                Icon(Icons.money_off),
                Text('Reactive and Generic Interpretation of Prescriptions',
                    style: AppTheme.subheading),
              ],
            ),
            Text(
              '''
There are thousands of missing procedure codes, likely stemming from systematic bias. Additionally, many codes, such as **BW21ZZZ** and **10D00Z0**, highlight a broader issue: the lack of personalization in healthcare. This underscores a system that prioritizes reactive approaches over proactive, patient-centered care.
''',
              style: AppTheme.subsubheadingtitle,
            ),
            Row(
              children: [
                Icon(Icons.money_off),
                Text('High Drug Costs and Data Gaps',
                    style: AppTheme.subheading),
              ],
            ),
            Text(
              '''
Theres a wide range in amount paid of prescriptions as high as \$359568.86 paid and as low as : -\$124248.5 refunded or lost through average activities.
''',
              style: AppTheme.subsubheadingtitle,
            ),
          ],
        )
      ],
    );
  }
}

class OnboardProblemStatement extends StatelessWidget {
  const OnboardProblemStatement({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Key Challenges in Modern Healthcare and Wellness',
          textAlign: TextAlign.center,
          style: AppTheme.heading,
        ),
        Column(
          children: [
            Row(
              children: [
                Icon(Icons.medication),
                Text(
                  'Medication Non-Adherence account to 50% of treatment failures',
                  style: AppTheme.subheading,
                ),
              ],
            ),
            Text(
              '75% of people with chronic conditions fail to take their medicine, leading to \$300 billion in healthcare costs and 125,000 preventable deaths annually. (Pharmacy Times)',
              style: AppTheme.subsubheadingtitle,
            ),
            Row(
              children: [
                Icon(Icons.food_bank),
                Text(
                  'Poor Diets Are Deadly',
                  style: AppTheme.subheading,
                ),
              ],
            ),
            Text(
              'Poor diets are linked to 20% of global deaths, highlighting the critical need for better nutrition choices. (Time)',
              style: AppTheme.subsubheadingtitle,
            ),
            Row(
              children: [
                Icon(Icons.directions_run),
                Text(
                  'Physical Inactivity Is a Global Risk',
                  style: AppTheme.subheading,
                ),
              ],
            ),
            Text(
              '1.8 billion adults are at heightened risk of disease due to insufficient physical activity. (WHO)',
              style: AppTheme.subsubheadingtitle,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.health_and_safety),
                Text(
                  'Good Diet and Physical Activity',
                  style: AppTheme.subheading,
                ),
              ],
            ),
            Text(
              'Good diet and physical activity are vital. They manage symptoms, boost the immune system, reduce risks, prevent diseases, and enhance quality of life.',
              style: AppTheme.subsubheadingtitle,
            ),
          ],
        ),
      ],
    );
  }
}
