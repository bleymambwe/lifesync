import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:lifesync/Utils/theme.dart';
import '../stateprovider.dart';
import 'package:provider/provider.dart';

class PrescriptionDashboard extends StatelessWidget {
  const PrescriptionDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlurryContainer(
            blur: 15,
            elevation: 5,
            color: Colors.transparent.withGreen(50),
            padding: EdgeInsets.all(8),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Text(
              'Current Plan',
              style: AppTheme.subsubsubheadingtitle,
            )),
        SizedBox(height: 60, width: 300, child: OptimiseCostButton())
      ],
    ));
  }
}

class OptimiseCostButton extends StatefulWidget {
  const OptimiseCostButton({super.key});

  @override
  State<OptimiseCostButton> createState() => _OptimiseCostButtonState();
}

class _OptimiseCostButtonState extends State<OptimiseCostButton> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<StateProvider>(
      builder: (context, stateProvider, child) {
        return Row(
          children: [
            // Search Input
            Expanded(
              child: BlurryContainer(
                blur: 15,
                elevation: 5,
                color: Colors.transparent.withGreen(50),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: TextField(
                  controller: _textController,
                  showCursor: true,
                  style: AppTheme.subsubsubheadingtitle,
                  decoration: InputDecoration(
                    hintText: "Enter drug name to optimise cost",
                    hintStyle: AppTheme.bodybodyText,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            InkWell(
              onTap: () {
                // Trigger the postDrug function
                final text = _textController.text.trim();
                if (text.isNotEmpty) {
                  stateProvider.checkStarted();
                  _textController.clear(); // Clear input after sending
                } else {
                  // Optionally display an error or feedback
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter text before sending"),
                    ),
                  );
                }
              },
              child: BlurryContainer(
                blur: 15,
                elevation: 5,
                color: Colors.transparent.withGreen(50),
                padding: const EdgeInsets.all(12),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: const Icon(Icons.send, color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
