import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class StateProvider extends ChangeNotifier {
  // Variable to store the response from the database
  String _responseText = '';
  String get responseText => _responseText;
  bool isBefore = false;

  // Firebase Database reference
  DatabaseReference? _databaseRef;

  // Constructor to set up the database listener
  StateProvider() {
    _initializeFirebase();
  }

  // Initialize Firebase and set up the database reference
  Future<void> _initializeFirebase() async {
    try {
      // Ensure Firebase is initialized
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      // Initialize database reference with the correct URL
      // Replace 'YOUR_FIREBASE_PROJECT_ID' with your actual Firebase project ID
      _databaseRef = FirebaseDatabase.instanceFor(
              app: Firebase.app(),
              databaseURL: 'https://lifesync-ai-default-rtdb.firebaseio.com/')
          .ref();

      // Ensure nodes exist
      await _ensureNodesExist();

      // Set up the response listener
      _listenToResponses();
    } catch (error) {
      print("Firebase initialization error: $error");
      _responseText = "Firebase initialization failed: $error";
      notifyListeners();
    }
  }

  // Ensure user/post and user/response nodes exist
  Future<void> _ensureNodesExist() async {
    try {
      // Null check for _databaseRef
      if (_databaseRef == null) {
        throw Exception("Database reference not initialized");
      }

      // Check and create user/post node if it doesn't exist
      DatabaseReference postRef = _databaseRef!.child('user/post');
      DataSnapshot postSnapshot = await postRef.get();
      if (!postSnapshot.exists) {
        await postRef.set({});
        print("Created streaming/post node");
      }

      // Check and create user/response node if it doesn't exist
      DatabaseReference responseRef = _databaseRef!.child('user/response');
      DataSnapshot responseSnapshot = await responseRef.get();
      if (!responseSnapshot.exists) {
        await responseRef.set({});
        print("Created user/response node");
      }
    } catch (error) {
      print("Error ensuring nodes exist: $error");
    }
  }

  // Function to post text to the database
  Future<void> postText(String text) async {
    String featureState = 'ai';
    try {
      // Null check for _databaseRef
      if (_databaseRef == null) {
        throw Exception("Database reference not initialized");
      }

      // Get the current timestamp
      final timestamp = DateTime.now().toIso8601String();

      // Construct the data to push
      final data = {
        'time': timestamp,
        'feature': featureState,
        'prompt': text,
      };

      // Push data to Firebase Realtime Database under the "streaming/post" node
      await _databaseRef!.child('streaming/post').push().set(data);
    } catch (error) {
      print("Failed to post text: $error");
      _responseText = "Failed to post text: $error";
      notifyListeners();
    }
  }

  // Function to listen to responses from the database
  void _listenToResponses() {
    try {
      // Null check for _databaseRef
      if (_databaseRef == null) {
        throw Exception("Database reference not initialized");
      }

      // Listen to all children added to the user/response node
      _databaseRef!.child('user/response').onChildAdded.listen((event) {
        // Print debug information
        print("Response event received: ${event.snapshot.value}");

        // Extract the response text from the database snapshot
        final responseData = event.snapshot.value;

        if (responseData is Map) {
          // Update the response text
          // Adjust the key based on how you're storing the response
          _responseText = responseData['text'] ?? responseData['message'] ?? '';

          print("Updated response text: $_responseText");

          // Notify listeners that the response has been updated
          notifyListeners();
        } else if (responseData is String) {
          // If the response is directly a string
          _responseText = responseData;
          print("Updated response text (direct string): $_responseText");
          notifyListeners();
        } else {
          print("Unexpected response data type: ${responseData.runtimeType}");
        }
      }, onError: (error) {
        print("Error listening to responses: $error");
        _responseText = "Error listening to responses: $error";
        notifyListeners();
      });

      // Additionally, listen for value events to catch existing data
      _databaseRef!.child('user/response').onValue.listen((event) {
        final responseData = event.snapshot.value;
        print("OnValue event received: $responseData");

        if (responseData is Map) {
          // If it's a map, find the most recent response
          final lastKey = (responseData.keys.toList()..sort()).last;
          final lastResponse = responseData[lastKey];

          if (lastResponse is Map) {
            _responseText =
                lastResponse['text'] ?? lastResponse['message'] ?? '';
          } else if (lastResponse is String) {
            _responseText = lastResponse;
          }

          print("Updated response text from onValue: $_responseText");
          notifyListeners();
        } else if (responseData is String) {
          _responseText = responseData;
          print(
              "Updated response text from onValue (direct string): $_responseText");
          notifyListeners();
        }
      }, onError: (error) {
        print("Error in onValue listener: $error");
      });
    } catch (error) {
      print("Failed to set up response listener: $error");
      _responseText = "Failed to set up response listener: $error";
      notifyListeners();
    }
  }
}
