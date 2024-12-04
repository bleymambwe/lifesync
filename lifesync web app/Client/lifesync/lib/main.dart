import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:ui';
import 'theme.dart';
import 'firebase_options.dart';
import 'onBoarding/onboarding.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LifeSync',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.secondaryColor),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  Future<String> getFirebaseImageUrl() async {
    try {
      final ref =
          FirebaseStorage.instance.ref('homepage/gradientgrainycompressed.png');
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error getting image URL: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.mainColor, AppTheme.secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // // Firebase image with blur effect
          // FutureBuilder<String>(
          //   future: getFirebaseImageUrl(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const Center(child: CircularProgressIndicator());
          //     } else if (snapshot.hasError ||
          //         !snapshot.hasData ||
          //         snapshot.data!.isEmpty) {
          //       return const Center(child: Text('Image not found'));
          //     } else {
          //       return Center(
          //         child: ClipRect(
          //           child: BackdropFilter(
          //             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //             child: Image.network(
          //               snapshot.data!,
          //               fit: BoxFit.cover,
          //               width: double.infinity,
          //               height: double.infinity,
          //               errorBuilder: (context, error, stackTrace) {
          //                 print('Image load error: $error');
          //                 return const Text('');
          //               },
          //             ),
          //           ),
          //         ),
          //       );
          //     }
          //   },
          // ),

          // Text content stacked above the blurred image
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'LifeSync',
                  style: AppTheme.titleLogo,
                ),
                const SizedBox(height: 8),
                const Text(
                  'AI tailored diet and exercises for personalized health care',
                  style: AppTheme.subtitleLogo,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 55,
                ),
                 Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                           Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OnboardingPage()),
    );
                    },
                    child: BlurryContainer(
                      child: Text(
                        'Get Started',
                        style: AppTheme.bodyText,
                      ),
                      blur: 15,
                      //width: 200,
                      //height: 200,
                      elevation: 5,
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(8),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// BlurryContainer(
//   child = YOUR_WIDGET(),
//   blur = 5,
//   width = 200,
//   height = 200,
//   elevation = 0,
//   color = Colors.transparent,
//   padding = const EdgeInsets.all(8),
//   borderRadius = const BorderRadius.all(Radius.circular(20)),
// ),