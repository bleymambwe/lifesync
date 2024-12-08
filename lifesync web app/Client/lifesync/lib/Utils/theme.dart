import 'package:flutter/material.dart';

const String homepageImage =
    'https://firebasestorage.googleapis.com/v0/b/lifesync-ai.firebasestorage.app/o/homepage%2Fgradientgrainycompressed.png?alt=media&token=51d03423-012c-4c26-bde3-6ef55f6a87dc';

class AppTheme {
  // Define color palette
  static const Color mainColor = Color(0xFFeeecde);
  static const Color primaryColor = Color(0xFFb0cece);
  static const Color secondaryColor = Color(0xFFebf2f3);
  static const Color tertiaryColor = Color(0xFFb4ccd4);
  static const Color brightColor = Color(0xFFe8ecec);
  static const Color gintColor = Color(0xFF156669);
  static const Color darkOrange = Color.fromARGB(255, 85, 112, 86);

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

  static const TextStyle heading = TextStyle(
    fontFamily: 'Roca',
    fontWeight: FontWeight.w900,
    fontSize: 24,
    color: Colors.black,
  );

  static TextStyle subheadingtitle = TextStyle(
    fontFamily: 'Roca',
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: darkOrange,
  );

  static TextStyle subsubheadingtitle = TextStyle(
    fontFamily: 'Roca',
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: darkOrange,
  );

  static TextStyle subsubsubheadingtitle = TextStyle(
    fontFamily: 'Roca',
    //fontWeight: FontWeight.w400,
    fontSize: 16,
    color: darkOrange,
  );

  static const TextStyle subheading = TextStyle(
    fontFamily: 'Roca',
    fontWeight: FontWeight.w400,
    fontSize: 20,
    color: secondaryColor,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Roca',
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: Colors.black54,
  );
}

extension ColorBrightnessAdjustment on Color {
  // Reduce brightness by 30%
  Color get thirty {
    return _adjustBrightness(0.7);
  }

  // Reduce brightness by 60%
  Color get sixty {
    return _adjustBrightness(0.4);
  }

  // Helper function to adjust brightness
  Color _adjustBrightness(double factor) {
    int r = (red * factor).toInt();
    int g = (green * factor).toInt();
    int b = (blue * factor).toInt();

    // Ensure the values don't exceed 255 or go below 0
    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    return Color.fromRGBO(r, g, b, opacity);
  }
}

class GContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const GContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade400,
            //Colors.green.shade200,
            Colors.green.shade300,
            //Colors.green.shade100,
            Colors.green.shade200,
            //AppTheme.mainColor,
            Colors.green.shade100,
            Colors.green.shade400,
          ],
          // begin: Alignment.topLeft,
          //end: Alignment.bottomRight,
          stops: [0.0, 0.2, 0.6, 0.8, 1.0],
          //const [0.0, 0.2, 0.4, 0.8, 1.0],
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.4),
            blurRadius: 10.0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: padding ?? const EdgeInsets.all(16.0),
      child: child,
    );
  }
}

class GreenContainer extends StatelessWidget {
  final Widget child;

  const GreenContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade400, Colors.green.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.4),
            blurRadius: 10.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0), // Adds internal spacing
      child: child, // Displays the provided child
    );
  }
}
