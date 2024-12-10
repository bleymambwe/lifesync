import 'package:flutter/material.dart';
import 'package:lifesync/Utils/theme.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:lifesync/Dashboard/dashboard.dart';
import 'package:lifesync/Utils/custom_transition.dart';

import 'package:lifesync/stateprovider.dart';
import 'package:provider/provider.dart';

class OnboardFinal extends StatelessWidget {
  const OnboardFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateProvider>(
      builder: (context, stateProvider, child) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  "Please fill in your details:",
                  style: AppTheme.subheadingtitle,
                ),
                const SizedBox(height: 24),
                // Row for Name and Age
                Row(
                  children: [
                    Expanded(
                      child: _buildBlurryTextField(
                        label: "Name",
                        hintText: "Enter your name",
                        onChanged: stateProvider.setName,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildBlurryTextField(
                        label: "Age",
                        hintText: "Enter your age",
                        keyboardType: TextInputType.number,
                        onChanged: stateProvider.setAge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Row for Contact Information, BP, and Sugar
                Row(
                  children: [
                    Expanded(
                      child: _buildBlurryTextField(
                        label: "Contact Information",
                        hintText: "Enter your contact info",
                        keyboardType: TextInputType.phone,
                        onChanged: stateProvider.setContact,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildBlurryTextField(
                        label: "Current BP",
                        hintText: "Enter BP",
                        onChanged: stateProvider.setBP,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildBlurryTextField(
                        label: "Sugar",
                        hintText: "Enter sugar level",
                        onChanged: stateProvider.setSugar,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Row for Underlying Condition and Prescription
                Row(
                  children: [
                    Expanded(
                      child: _buildBlurryTextField(
                        label: "Underlying Condition",
                        hintText: "Enter any underlying conditions",
                        onChanged: stateProvider.setUnderlyingCondition,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildBlurryTextField(
                        label: "Prescription",
                        hintText: "Enter your prescription",
                        onChanged: stateProvider.setPrescription,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {
                  // Validate and post details before navigating
                  if (stateProvider.validateForm()) {
                    // Post details to Firebase
                    stateProvider.postDetails(context);

                    // Navigate to Dashboard
                    Navigator.of(context).push(
                      CustomPageRoute(
                        page: const DashboardPage(),
                        transitionType: TransitionType.fade,
                      ),
                    );
                  } else {
                    // Show validation error dialog
                    stateProvider.postDetails(context);
                  }
                },
                child: const GContainer(
                  child: Text(
                    'Get Started',
                    style: AppTheme.bodyText,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBlurryTextField({
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
  }) {
    return BlurryContainer(
      blur: 15,
      elevation: 5,
      color: Colors.transparent.withGreen(50),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTheme.subsubheadingtitle,
          ),
          const SizedBox(height: 8),
          TextField(
            keyboardType: keyboardType,
            style: AppTheme.bodyText,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTheme.bodybodyText,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
