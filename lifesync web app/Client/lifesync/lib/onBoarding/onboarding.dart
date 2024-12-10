library mylibrary;

import 'package:flutter/material.dart';
import 'package:lifesync/Utils/theme.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:lifesync/Dashboard/dashboard.dart';
import 'onboardingcarousel.dart';
import 'package:lifesync/Utils/custom_transition.dart';
import 'onboardfour.dart';

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
            child: OnboardingCarousel(width: 600, height: 600, slides: [
              onboardStart(),
              onboardOne(),
              onboardTwo(),
              onboardThree(),
              onboardFour(),
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

class onboardStart extends StatelessWidget {
  const onboardStart({super.key});

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
                Text('High Drug Costs and Data Gaps',
                    style: AppTheme.subheading),
              ],
            ),
            Text(
              '''
Theres a wide range in amount paid of prescriptions as high as 359568.86 paid and as low as : -124248.5 refunded or lost through average activities.
''',
              style: AppTheme.subsubheadingtitle,
            ),
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
            )
          ],
        )
      ],
    );
  }
}

class OnboardFinal extends StatelessWidget {
  const OnboardFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              "Please fill in your details:",
              style: AppTheme.subheadingtitle,
            ),
            const SizedBox(height: 24),
            // Row for Name and Age
            Row(
              children: [
                Expanded(
                  child: _buildBlurryTextField(
                    label: "Name",
                    hintText: "Enter your name",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBlurryTextField(
                    label: "Age",
                    hintText: "Enter your age",
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Row for Contact Information, BP, and Sugar
            Row(
              children: [
                Expanded(
                  child: _buildBlurryTextField(
                    label: "Contact ",
                    hintText: "Include your country code e.g +44..",
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBlurryTextField(
                    label: "Current BP",
                    hintText: "Enter BP",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBlurryTextField(
                    label: "Sugar",
                    hintText: "Enter sugar level",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Row for Underlying Condition and Prescription
            Row(
              children: [
                Expanded(
                  child: _buildBlurryTextField(
                    label: "Underlying Condition",
                    hintText: "Enter any underlying conditions",
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBlurryTextField(
                    label: "Prescription",
                    hintText: "Enter your prescription",
                  ),
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
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
            child: const GContainer(
              // blur: 15,
              // elevation: 5,
              // color: Colors.transparent,
              // padding: EdgeInsets.all(8),
              // borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Text(
                'Get Started',
                style: AppTheme.bodyText,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBlurryTextField({
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return BlurryContainer(
      blur: 15,
      elevation: 5,
      color: Colors.transparent.withGreen(50),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTheme.subsubheadingtitle,
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: keyboardType,
            style: AppTheme.bodyText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTheme.bodybodyText,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
