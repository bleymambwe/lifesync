import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:lifesync/Dashboard/drugtable.dart';
import 'package:lifesync/Dashboard/homedashboard.dart';
import '../Utils/custom_transition.dart';
import 'package:provider/provider.dart';
import '../stateprovider.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import '../Utils/theme.dart';
import 'package:lifesync/Dashboard/tablayout.dart';
import 'prescriptiondashboard.dart';
import 'dash.dart';
import 'datawidget.dart';
import 'sdui.dart';
import 'homedashboard.dart';
import 'dart:convert';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic>? planData; // Make planData nullable

  @override
  void initState() {
    super.initState();
    _loadPlanData(); // Load data when the widget initializes
  }

  Future<void> _loadPlanData() async {
    // String jsonString = '''
    // {
    //   "Plan": {
    //     "Summary": {
    //       "description": "High-fiber foods and Vitamin B for stable sugar. Yoga and breathing exercises for lung function and glucose control."
    //     },
    //     "Diet": {
    //       "morning": "Oatmeal with berries and nuts",
    //       "brunch": "Greek yogurt with fruit",
    //       "afternoon": "Salad with grilled chicken",
    //       "supper": "Salmon with steamed vegetables"
    //     },
    //     "Fitness": {
    //       "morning": "30 minutes of yoga",
    //       "afternoon": "15 minutes of brisk walking"
    //     },
    //     "Water_target": 2000,
    //     "Calories_target": 1800,
    //     "Cost": 25
    //   }
    // }
    // ''';

    String jsonString = '''
{
  "Plan": {
    "Summary": {
      "description": "High-fiber foods and Vitamin B for stable sugar. Yoga and breathing exercises for lung function and glucose control."
    },
    "Diet": {
      "morning": "Oatmeal with almond milk, topped with chia seeds.",
      "brunch": "Apple slices with a handful of unsalted almonds.",
      "afternoon": "Grilled chicken salad with leafy greens and olive oil.",
      "supper": "Steamed salmon with quinoa and steamed broccoli."
    },
    "Fitness": {
      "morning": "10 minutes of breathing exercises and light yoga.",
      "afternoon": "30-minute brisk walk or low-impact aerobics."
    },
    "Water_target": 2000,
    "Calories_target": 1800,
    "Cost": 50
  }
}

    ''';

    try {
      Map<String, dynamic> decodedJson =
          jsonDecode(jsonString); // from dart:convert

      setState(() {
        planData = decodedJson;
      });
    } catch (e) {
      print("Error loading plan data: $e");
      setState(() {
        planData = null; // Or provide a default empty map
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.mainColor, AppTheme.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DashboardAppBar(),
                TabLayout(),
                const SizedBox(height: 12),

                // Consumer<StateProvider>(
                //   builder: (context, provider, child) {
                //     if (provider.buttonState == 'Drug') {
                //       return PrescriptionDashboard();
                //     }
                //     return SizedBox
                //         .shrink(); // Fallback widget if the buttonState is not 'Drug'
                //   },
                // ),

                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: 850,
                          child: Consumer<StateProvider>(
                            builder: (context, stateProvider, child) {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                      opacity: animation, child: child);
                                },
                                child: stateProvider.buttonState == 'Home'
                                    ? HomeDashboard(
                                        key: ValueKey('Home'),
                                        planData: planData!)
                                    : DrugTableX(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 100.0, // Circle size
          height: 100.0,
          child: ClipOval(
            child: Image.asset(
              'assets/dp.jpg', // Image from assets
              width: 100.0, // Circle size
              height: 100.0,
              fit: BoxFit.cover, // Fit parameter to adjust image scaling
            ), // Image URL or use AssetImage for local assets
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              SizedBox(
                height: 55,
                width: 60,
                child: BlurryContainer(
                    blur: 15,
                    elevation: 5,
                    color: Colors.transparent,
                    padding: EdgeInsets.all(8),
                    child: UploadWidget()),
              ),
              SizedBox(
                width: 15,
              ),
              BlurryContainer(
                  blur: 15,
                  elevation: 5,
                  color: Colors.transparent,
                  padding: EdgeInsets.all(8),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    width: 600,
                    // height: 0,
                    child: Text(
                      'High-fiber foods and Vitamin B for stable sugar. Yoga and breathing exercises for lung function and glucose control',
                      style: AppTheme.subheadingtitle,
                      textAlign: TextAlign.center,
                    ),
                  )),
              SizedBox(
                width: 15,
              ),
              SizedBox(
                height: 55,
                width: 60,
                child: BlurryContainer(
                    blur: 15,
                    elevation: 5,
                    color: Colors.transparent,
                    padding: EdgeInsets.all(8),
                    child: CallWidget()),
              )
            ],
          ),
        ),
        SizedBox(
          height: 120,
          child: AnimatedDial(
              initialValue: 15,
              finalValue: 84,
              initialUnits: 'UAS%',
              finalUnits: 'UAS%'),
        ),
        //SizedBox(width: 300, child: Container())
      ],
    );
  }
}

class AnimatedDial extends StatefulWidget {
  final double initialValue;
  final double finalValue;
  final String initialUnits;
  final String finalUnits;

  const AnimatedDial({
    super.key,
    required this.initialValue,
    required this.finalValue,
    required this.initialUnits,
    required this.finalUnits,
  });

  @override
  State<AnimatedDial> createState() => _AnimatedDialState();
}

class _AnimatedDialState extends State<AnimatedDial> {
  /// Build method of your widget.
  @override
  Widget build(BuildContext context) {
    return Consumer<StateProvider>(
      builder: (context, stateProvider, child) {
        final isBefore = stateProvider.isBefore;
        return AnimatedRadialGauge(
          /// The animation duration.
          duration: const Duration(seconds: 1),
          curve: Curves.elasticOut,

          /// Define the radius.
          /// If you omit this value, the parent size will be used, if possible.
          radius: 100,

          /// Gauge value.
          value: isBefore ? widget.initialValue : widget.finalValue,

          /// Optionally, you can configure your gauge, providing additional
          /// styles and transformers.
          axis: GaugeAxis(

              /// Provide the [min] and [max] value for the [value] argument.
              min: 0,
              max: 100,

              /// Render the gauge as a 180-degree arc.
              degrees: 185,

              /// Set the background color and axis thickness.
              style: const GaugeAxisStyle(
                thickness: 20,
                background: AppTheme.gintColor,
                segmentSpacing: 0,
                blendColors: true,
              ),

              /// Define the progress bar (optional).
              progressBar: GaugeProgressBar.rounded(
                shader: SweepGradient(
                  colors: [
                    Colors.green.shade400,
                    AppTheme.mainColor,

                    //const Color(0xFFB4C2F8),
                    //const Color(0xFF193663),
                    //Colors.purple,
                    //Colors.blueGrey,
                    AppTheme.darkOrange,
                    //Colors.purpleAccent.shade100,
                    Colors.black38,
                    AppTheme.gintColor
                    //Colors.purpleAccent.shade400,
                  ],
                  stops: const [
                    0.0,
                    0.2,
                    0.4,
                    // 0.6,
                    0.8,
                    // 0.2,
                    1.0,
                  ],
                ).createShader(Rect.fromCircle(
                  center: const Offset(0, 0),
                  radius: 100,
                )),
                color: const Color(0xFFB4C2F8),
              ),

              /// Define axis segments (optional).
              segments: [
                GaugeSegment(
                  from: 0,
                  to: 100,
                  color: Colors.grey.shade200,
                  cornerRadius: const Radius.circular(29),
                ),
              ]),

          builder: (context, child, value) => Column(
            children: [
              RadialGaugeLabel(
                value: value,
                style: AppTheme.subheadingtitle,
              ),
              Text(
                isBefore ? widget.initialUnits : widget.finalUnits,
                style: AppTheme
                    .subheadingtitle, // const TextStyle(fontWeight: FontWeight.w800
                //  ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CallWidget extends StatefulWidget {
  const CallWidget({super.key});

  @override
  State<CallWidget> createState() => _CallWidgetState();
}

class _CallWidgetState extends State<CallWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateProvider>(builder: (context, stateProvider, child) {
      return IconButton(
          onPressed: () {
            stateProvider.postCall();
          },
          icon: Icon(
            Icons.call,
          ));
    });
  }
}

class UploadWidget extends StatefulWidget {
  const UploadWidget({super.key});

  @override
  State<UploadWidget> createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateProvider>(builder: (context, stateProvider, child) {
      return IconButton(
          onPressed: () {
            stateProvider.openCameraOrFilePicker();
          },
          icon: Icon(
            Icons.camera,
          ));
    });
  }
}
