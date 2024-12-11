import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'Utils/theme.dart';
import 'firebase_options.dart';
import 'onBoarding/onboarding.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'Utils/custom_transition.dart';
import 'Dashboard/dashboard.dart';
import 'package:provider/provider.dart';
import 'stateprovider.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<StateProvider>(
            create: (context) => StateProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e) {
    print('Firebase initialization error: $e');
    // Optionally, show an error widget or log the error
  }
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
      home: const SharedScaffold(),
    );
  }
}

class SharedScaffold extends StatelessWidget {
  const SharedScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        initialRoute: '/home',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => const DashboardPage());
            case '/onboarding':
              return MaterialPageRoute(builder: (_) => const OnboardingPage());
            case '/dashboard':
              return MaterialPageRoute(builder: (_) => const DashboardPage());
            default:
              return MaterialPageRoute(builder: (_) => const DashboardPage());
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Future<String> getFirebaseImageUrl() async {
  //   try {
  //     final ref =
  //         FirebaseStorage.instance.ref('homepage/gradientgrainycompressed.png');
  //     return await ref.getDownloadURL();
  //   } catch (e) {
  //     print('Error getting image URL: $e');
  //     return '';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
        // Center(
        //     child: Opacity(
        //         opacity: 0.1,
        //         child: Image.asset('assets/gradientgrainycompressed.png'))

        //         ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'LifeSync',
                    style: AppTheme.titleLogo,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Prescition cost optimizer and  AI tailored diet and fitness for personalized health care',
                style: AppTheme.subtitleLogo,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 55),
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      CustomPageRoute(
                        page: const OnboardingPage(),
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
          ),
        ),
      ],
    );
  }
}
