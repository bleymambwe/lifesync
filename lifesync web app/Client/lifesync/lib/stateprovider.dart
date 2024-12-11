import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class StateProvider extends ChangeNotifier {
  bool isBefore = false;
  String _responseText = '';
  String get responseText => _responseText;

  String _drugResponseText = '';
  String get drugResponseText => _drugResponseText;

  List<Map<String, dynamic>> _potentialSubstitutes = [];
  List<Map<String, dynamic>> get potentialSubstitutes => _potentialSubstitutes;

  DatabaseReference? _databaseRef;

  // Form field variables
  String name = '';
  String age = '';
  String contact = '';
  String bp = '';
  String sugar = '';
  String underlyingCondition = '';
  String prescription = '';

  // Computed condition variable (concatenation of everything except name and contact)
  String get condition {
    // Combine all additional details
    return [age, bp, sugar, underlyingCondition, prescription]
        .where((element) => element.isNotEmpty)
        .join(' | ');
  }

  // Function to validate form fields
  bool validateForm() {
    return name.isNotEmpty &&
        age.isNotEmpty &&
        contact.isNotEmpty &&
        underlyingCondition.isNotEmpty;
  }

  StateProvider() {
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      _databaseRef = FirebaseDatabase.instanceFor(
              app: Firebase.app(),
              databaseURL: 'https://lifesync-ai-default-rtdb.firebaseio.com/')
          .ref();

      await _ensureNodesExist();

      _listenToResponses();
      _listenToDrugResponses(); // New listener for drug substitute responses
    } catch (error) {
      print("Firebase initialization error: $error");
      _responseText = "Firebase initialization failed: $error";
      notifyListeners();
    }
  }

  Future<void> _ensureNodesExist() async {
    try {
      if (_databaseRef == null) {
        throw Exception("Database reference not initialized");
      }

      DatabaseReference mainRef = _databaseRef!.child('user/response/main');
      DataSnapshot mainSnapshot = await mainRef.get();
      if (!mainSnapshot.exists) {
        await mainRef.set({});
        print("Created user/response/main node");
      }

      DatabaseReference drugRef =
          _databaseRef!.child('user/response/drug_substitute');
      DataSnapshot drugSnapshot = await drugRef.get();
      if (!drugSnapshot.exists) {
        await drugRef.set({});
        print("Created user/response/drug_substitute node");
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

  // Function to post text to the database
  Future<void> postCall() async {
    String featureState = 'call';
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
        // 'prompt': text,
      };

      // Push data to Firebase Realtime Database under the "streaming/post" node
      await _databaseRef!.child('streaming/post').push().set(data);
    } catch (error) {
      print("Failed to post text: $error");
      _responseText = "Failed to post text: $error";
      notifyListeners();
    }
  }

  Future<void> postDrug(String text) async {
    try {
      if (_databaseRef == null) {
        throw Exception("Database reference not initialized");
      }

      final timestamp = DateTime.now().toIso8601String();
      final data = {
        'time': timestamp,
        'feature': 'drug substitute',
        'prompt': text,
      };

      await _databaseRef!.child('streaming/post').push().set(data);
    } catch (error) {
      print("Failed to post drug: $error");
      _responseText = "Failed to post drug: $error";
      notifyListeners();
    }
  }

  void _listenToResponses() {
    try {
      // Null check for _databaseRef
      if (_databaseRef == null) {
        throw Exception("Database reference not initialized");
      }

      // Listen to all children added to the user/response node
      _databaseRef!.child('user/response/main').onChildAdded.listen((event) {
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
      _databaseRef!.child('user/response/main').onValue.listen((event) {
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

  // void _listenToDrugResponses() {
  //   try {
  //     if (_databaseRef == null) {
  //       throw Exception("Database reference not initialized");
  //     }

  //     // Listen to all children added to the drug substitute response node
  //     _databaseRef!
  //         .child('user/response/drug_substitute/response')
  //         .onChildAdded
  //         .listen((event) {
  //       final responseData = event.snapshot.value;

  //       print("Drug substitute response received: $responseData");

  //       if (responseData is String) {
  //         // Handle string response directly
  //         _drugResponseText = responseData;
  //         print("Updated drug response text (String): $_drugResponseText");
  //       } else if (responseData is List) {
  //         // Handle list of potential substitutes
  //         _potentialSubstitutes = responseData.cast<Map<String, dynamic>>();

  //         _drugResponseText =
  //             _potentialSubstitutes.asMap().entries.map((entry) {
  //           final index = entry.key;
  //           final item = entry.value;
  //           final substanceName = item['substance_name'] ?? 'Unknown';
  //           final brandNames = (item['brand_names'] as List?)?.join(', ') ??
  //               'No brands available';
  //           return '[$index] Substance: $substanceName, Brands: $brandNames';
  //         }).join('\n');

  //         print("Updated drug response text (List): $_drugResponseText");
  //       } else {
  //         // Unexpected format
  //         print("Unexpected response data type: ${responseData.runtimeType}");
  //         _drugResponseText = "Unexpected response data format.";
  //       }
  //       notifyListeners();
  //     }, onError: (error) {
  //       print("Error listening to drug responses: $error");
  //       _drugResponseText = "Error listening to drug responses: $error";
  //       notifyListeners();
  //     });
  //   } catch (error) {
  //     print("Failed to set up drug response listener: $error");
  //     _drugResponseText = "Failed to set up drug response listener: $error";
  //     notifyListeners();
  //   }
  // }

  void _listenToDrugResponses() {
    try {
      if (_databaseRef == null) {
        throw Exception("Database reference not initialized");
      }

      _databaseRef!
          .child('user/response/drug_substitute/response')
          .onChildAdded
          .listen((event) {
        final responseData = event.snapshot.value;

        print("Drug substitute response received: $responseData");

        if (responseData is List) {
          // Parse as a list of maps
          _potentialSubstitutes = responseData.map((item) {
            if (item is Map) {
              return Map<String, dynamic>.from(item);
            } else {
              throw FormatException("Invalid item type in response");
            }
          }).toList();
        } else {
          // Unexpected response
          print("Unexpected response data type: ${responseData.runtimeType}");
          _potentialSubstitutes = [];
        }
        notifyListeners();
      }, onError: (error) {
        print("Error listening to drug responses: $error");
        _potentialSubstitutes = [];
        notifyListeners();
      });
    } catch (error) {
      print("Failed to set up drug response listener: $error");
      _potentialSubstitutes = [];
      notifyListeners();
    }
  }

  Future<void> postDetails(BuildContext context) async {
    print('Attempting to post details');
    try {
      if (_databaseRef == null) {
        print('Database reference is null');
        throw Exception("Database reference not initialized");
      }

      // More robust form validation
      if (!validateForm()) {
        print('Form validation failed');
        _showValidationErrorDialog(context);
        return;
      }

      final timestamp = DateTime.now().toIso8601String();

      final data = {
        'time': timestamp,
        'user_details': {
          'name': name,
          'age': age,
          'contact': contact,
          'bp': bp,
          'sugar': sugar,
          'underlying_condition': underlyingCondition,
          'prescription': prescription,
          'condition': condition
        }
      };

      // More verbose logging
      print('Prepared data to post: $data');

      // Directly updating the existing 'user/details' node
      DatabaseReference userDetailsRef = _databaseRef!.child('user/details');
      print('Existing reference to update: ${userDetailsRef.path}');

      await userDetailsRef.set(data).then((_) {
        print(
            "Details successfully uploaded to reference: ${userDetailsRef.path}");
      }).catchError((error) {
        print("Error setting data: $error");
        throw error;
      });
    } catch (error) {
      print("Comprehensive error in postDetails: $error");
      // Optional: show a snackbar or toast to user about the error
    }
  }

  // Method to show validation error dialog
  void _showValidationErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Incomplete Information'),
          content: Text(
              'Please fill in all required fields:\n- Name\n- Age\n- Contact Information\n- Underlying Condition'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Setters for form fields
  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setAge(String value) {
    age = value;
    notifyListeners();
  }

  void setContact(String value) {
    contact = value;
    notifyListeners();
  }

  void setBP(String value) {
    bp = value;
    notifyListeners();
  }

  void setSugar(String value) {
    sugar = value;
    notifyListeners();
  }

  void setUnderlyingCondition(String value) {
    underlyingCondition = value;
    notifyListeners();
  }

  void setPrescription(String value) {
    prescription = value;
    notifyListeners();
  }

  void checkStarted() {
    print('welcome to the homepage');
  }
}
