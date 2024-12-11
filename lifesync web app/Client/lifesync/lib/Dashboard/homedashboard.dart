import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart'; // Make sure you have this package installed
import '../Utils/theme.dart'; // Import your AppTheme

class HomeDashboard extends StatelessWidget {
  final Map<String, dynamic> planData;

  const HomeDashboard({Key? key, required this.planData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plan = planData['Plan'];

    if (plan == null) {
      return const Center(child: Text("No plan data available."));
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Section
            // _buildBlurryContainer(
            //   title: "Plan Summary",
            //   content: plan['Summary']['description'],
            //   style: AppTheme.subheading,
            // ),
            //const SizedBox(height: 16),
            // Targets and Cost
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTarget("Water Target", "${plan['Water_target']} ml"),
                _buildTarget(
                    "Calories Target", "${plan['Calories_target']} kcal"),
                _buildTarget("Estimated Cost", "\$${plan['Cost']}"),
              ],
            ),
            const SizedBox(height: 16),

            _buildSection("Diet", plan['Diet']),
            const SizedBox(height: 16),
            // Fitness Section
            _buildSection("Fitness", plan['Fitness']),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBlurryContainer(
      {required String title,
      required String content,
      required TextStyle style}) {
    return BlurryContainer(
      blur: 5,
      elevation: 5,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTheme.subsubheadingtitle),
            const SizedBox(height: 8),
            Text(content, style: style),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTheme.subheading),
          const SizedBox(height: 8),
          ...data.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlurryContainer(
                      blur: 15,
                      elevation: 5,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: Text(entry.key, style: AppTheme.bodyText)),
                  BlurryContainer(
                      blur: 15,
                      elevation: 5,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: Text(entry.value, style: AppTheme.bodyTextGreen)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTarget(String title, String value) {
    return BlurryContainer(
      blur: 5,
      elevation: 5,
      color: Colors.transparent,
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Text(value, style: AppTheme.subheadingtitle),
          Text(title, style: AppTheme.bodyText.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}
