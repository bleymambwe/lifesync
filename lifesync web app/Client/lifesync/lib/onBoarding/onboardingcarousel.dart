import 'package:flutter/material.dart';

class OnboardingCarousel extends StatefulWidget {
  final double width;
  final double height;
  final List<Widget> slides;

  const OnboardingCarousel({
    super.key,
    required this.width,
    required this.height,
    required this.slides,
  });

  @override
  _OnboardingCarouselState createState() => _OnboardingCarouselState();
}

class _OnboardingCarouselState extends State<OnboardingCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.slides.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return widget.slides[index];
            },
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.slides.length,
                (index) => _buildIndicator(index == _currentPage),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
