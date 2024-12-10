import 'package:flutter/material.dart';
import '../Utils/theme.dart';

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

  void _goToSlide(int index) {
    if (index >= 0 && index < widget.slides.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          // PageView for slides
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
          // Page indicators
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
          // Navigation arrows
          Align(
            alignment: Alignment.bottomLeft,
            child: GContainer(
              child: Visibility(
                visible: _currentPage > 0,
                child: IconButton(
                  onPressed: () {
                    _goToSlide(_currentPage - 1);
                  },
                  icon: const Icon(Icons.arrow_back, size: 32),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GContainer(
              child: Visibility(
                visible: _currentPage < widget.slides.length - 1,
                child: IconButton(
                  onPressed: () {
                    _goToSlide(_currentPage + 1);
                  },
                  icon: const Icon(Icons.arrow_forward, size: 32),
                ),
              ),
            ),
          ),
          // Skip button
          Positioned(
            top: 20,
            right: 20,
            child: GContainer(
              child: Visibility(
                visible: _currentPage < widget.slides.length - 1,
                child: TextButton(
                  onPressed: () {
                    _goToSlide(widget.slides.length - 1);
                  },
                  child: Text(
                    "Skip",
                    style: AppTheme.subheading,
                  ),
                ),
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
        color: isActive ? AppTheme.gintColor : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
