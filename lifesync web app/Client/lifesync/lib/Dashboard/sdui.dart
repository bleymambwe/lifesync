import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stateprovider.dart'; // Import your StateProvider file here

class DrugSubstituteUI extends StatelessWidget {
  DrugSubstituteUI({Key? key}) : super(key: key);

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<StateProvider>(
      builder: (context, stateProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Drug Substitute Finder'),
            backgroundColor: Colors.green,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text input field
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Enter drug name or details',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.medical_services),
                  ),
                ),
                SizedBox(height: 16),

                // Submit button
                ElevatedButton(
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      // Call postDrug method from StateProvider
                      stateProvider.postDrug(_textController.text);
                      _textController.clear(); // Clear the text field
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('Send'),
                ),

                SizedBox(height: 32),

                // Display area for responses
                Text(
                  'Latest Response:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    stateProvider.drugResponseText.isEmpty
                        ? 'No response yet'
                        : stateProvider.drugResponseText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
