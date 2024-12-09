import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../stateprovider.dart'; // Import your StateProvider file here

class DataWidget extends StatelessWidget {
  DataWidget({Key? key}) : super(key: key);

  // Text controller for the input field
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<StateProvider>(
      builder: (context, stateProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Firebase Realtime Database Example'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text input field
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Enter your text',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // Submit button
                ElevatedButton(
                  onPressed: () {
                    // Call postText method from StateProvider
                    if (_textController.text.isNotEmpty) {
                      stateProvider.postText(_textController.text);
                      _textController
                          .clear(); // Clear the text field after posting
                    }
                  },
                  child: Text('Post Text'),
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
                Text(
                  stateProvider.responseText.isEmpty
                      ? 'No response yet'
                      : stateProvider.responseText,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
