import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lifesync/Utils/theme.dart';
import 'package:lifesync/stateprovider.dart';

class TabLayout extends StatelessWidget {
  const TabLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateProvider>(
      builder: (context, stateProvider, child) {
        final currentButtonState = stateProvider.buttonState;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Tab
            InkWell(
              onTap: () {
                stateProvider.changeButtonState('Home');
              },
              child: GContainer(
                child: Container(
                  child: Text(
                    'Home',
                    style: currentButtonState == 'Home'
                        ? AppTheme.subheadingtitle
                            .copyWith(color: Colors.greenAccent)
                        : AppTheme.subsubheadingtitle,
                  ),
                ),
              ),
            ),
            // Prescription Tab
            InkWell(
              onTap: () {
                stateProvider.changeButtonState('Prescription');
              },
              child: GContainer(
                child: Container(
                  child: Text(
                    'Prescription',
                    style: currentButtonState == 'Prescription'
                        ? AppTheme.subheadingtitle
                            .copyWith(color: Colors.greenAccent)
                        : AppTheme.subsubheadingtitle,
                  ),
                ),
              ),
            ),
            // Diet Tab
            InkWell(
              onTap: () {
                stateProvider.changeButtonState('Diet');
              },
              child: GContainer(
                child: Container(
                  child: Text(
                    'Diet',
                    style: currentButtonState == 'Diet'
                        ? AppTheme.subheadingtitle
                            .copyWith(color: Colors.greenAccent)
                        : AppTheme.subsubheadingtitle,
                  ),
                ),
              ),
            ),
            // Fitness Tab
            InkWell(
              onTap: () {
                stateProvider.changeButtonState('Fitness');
              },
              child: GContainer(
                child: Container(
                  child: Text(
                    'Fitness',
                    style: currentButtonState == 'Fitness'
                        ? AppTheme.subheadingtitle
                            .copyWith(color: Colors.greenAccent)
                        : AppTheme.subsubheadingtitle,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
