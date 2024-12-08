import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;
  final TransitionType transitionType;

  CustomPageRoute({
    required this.page,
    this.transitionType = TransitionType.fade,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (transitionType) {
              case TransitionType.fade:
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              case TransitionType.slide:
                const begin = Offset(1.0, 0.0); // Slide from right
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              case TransitionType.scale:
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              case TransitionType.rotate:
                return RotationTransition(
                  turns: animation,
                  child: child,
                );
              default:
                return child;
            }
          },
        );
}

enum TransitionType {
  fade,
  slide,
  scale,
  rotate,
}
