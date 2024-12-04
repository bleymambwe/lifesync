import 'package:flutter/material.dart';
import 'dart:ui';

const String homepageImage = 'https://firebasestorage.googleapis.com/v0/b/lifesync-ai.firebasestorage.app/o/homepage%2Fgradientgrainycompressed.png?alt=media&token=51d03423-012c-4c26-bde3-6ef55f6a87dc';

class AppTheme {
  // Define color palette
  static const Color mainColor = Color(0xFFeeecde);
  static const Color primaryColor = Color(0xFFb0cece);
  static const Color secondaryColor = Color(0xFFebf2f3);
  static const Color tertiaryColor = Color(0xFFb4ccd4);
  static const Color brightColor = Color(0xFFe8ecec);
  static const Color gintColor = Color(0xFF156669);

    // Define text styles
  static const TextStyle titleLogo = TextStyle(
    fontFamily: 'Roca',
    fontWeight: FontWeight.w500,
    fontSize: 80,
    color: gintColor,
  );
    static const TextStyle subtitleLogo = TextStyle(
    fontFamily: 'Roca',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: gintColor,
  );

  // Define text styles
  static const TextStyle heading = TextStyle(
    fontFamily: 'Roca',
    fontWeight: FontWeight.w900,
    fontSize: 24,
    color: Colors.black,
  );

  static const TextStyle subheading = TextStyle(
    fontFamily: 'Roca',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: Colors.black87,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Roca',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: Colors.black54,
  );

  // // Define the overall theme
  // static ThemeData get lightTheme {
  //   return ThemeData(
  //     primaryColor: primaryColor,
  //     scaffoldBackgroundColor: secondaryColor,
  //     textTheme: TextTheme(
  //       headline1: heading,
  //       headline6: subheading,
  //       bodyText1: bodyText,
  //     ),
  //     colorScheme: ColorScheme.light(
  //       primary: primaryColor,
  //       secondary: tertiaryColor,
  //     ),
  //   );
  // }
}

// class LSContainer extends StatelessWidget {
//   final Widget child;
//   final double? width;
//   final double? height;
//   final BorderRadius? borderRadius;

//   const LSContainer({
//     super.key, 
//     required this.child,
//     this.width,
//     this.height,
//     this.borderRadius,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         borderRadius: borderRadius ?? BorderRadius.circular(12),
//         border: Border.all(
//           color: AppTheme.gintColor, // Assuming this is a gradient color from your theme
//           width: 1.5,
//         ),
//         gradient: LinearGradient(
//           colors: [
//             AppTheme.mainColor.withOpacity(0.3), 
//             AppTheme.secondaryColor.withOpacity(0.3)
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: ClipRRect(
//         borderRadius: borderRadius ?? BorderRadius.circular(12),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 20, sigmaY: 12),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//             ),
//             child: child,
//           ),
//         ),
//       ),
//     );
//   }
// }

