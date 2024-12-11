import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:lifesync/Dashboard/drugtable.dart';
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

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
              // CallWidget(),

              // Container(
              //   color: Colors.grey,
              //   height: 5,
              //   width: double.infinity,
              // ),
              // TabLayout(),
              // Container(
              //   color: Colors.grey,
              //   height: 5,
              //   width: double.infinity,
              // ),
              PrescriptionDashboard(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 850,
                        height: 700,
// //color: Colors.green,
                        //  SDUI(),
                        child: DrugTableX(),
                      ),
                      // In your DrugSearchPage or similar widget
// DrugSubstituteTable(
//   substitutes: _stateProvider.potentialSubstitutes
// )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )),
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
          child: BlurryContainer(
              blur: 15,
              elevation: 5,
              color: Colors.transparent,
              padding: EdgeInsets.all(8),
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Container(
                width: 300,
                // height: 0,
                child: Text(
                  'Next: High Fiber foods',
                  style: AppTheme.subheadingtitle,
                  textAlign: TextAlign.center,
                ),
              )),
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
    return Row(
      children: [
        //SizedBox(width: 600, height: 400, child: DrugSubstituteUI()),
        // SizedBox(width: 600, height: 400, child: DataWidget()),
        SizedBox(
            width: 600,
            height: 400,
            child: Consumer<StateProvider>(
                builder: (context, stateProvider, child) {
              return Column(
                children: [
                  IconButton.filledTonal(
                      onPressed: () {
                        stateProvider.postCall();
                      },
                      icon: Icon(Icons.call)),
                  Text('data')
                ],
              );
            })),
      ],
    );
  }
}
