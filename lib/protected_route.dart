// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class ProtectedRoute extends StatelessWidget {
//   final Widget child;
//   final _secureStorage = FlutterSecureStorage();

//   ProtectedRoute({required this.child});

//   Future<bool> _isLoggedIn() async {
//     String? token = await _secureStorage.read(key: 'token');
//     return token != null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<bool>(
//       future: _isLoggedIn(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(body: Center(child: CircularProgressIndicator()));
//         }

//         if (snapshot.hasData && snapshot.data == true) {
//           return child;
//         }

//         return Scaffold(
//           body: Center(
//             child: Text('Please log in to access this page.'),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProtectedRoute extends StatelessWidget {
  final Widget child;

  const ProtectedRoute({required this.child});

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Required'),
          content: const Text('You need to log in to access this page.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context)
                    .pushReplacementNamed('/'); // Redirect to login
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData && snapshot.data == true) {
          return child;
        }

        // Notify the user that they need to log in to access the page
        Future.microtask(() {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('You need to log in to access this page.'),
          //   ),
          // );
          Navigator.of(context).pushReplacementNamed('/');

          // Redirect to the login page after showing the message
        });
        // Show the dialog to notify the user and redirect
        // Future.microtask(() => _showLoginDialog(context));

        return const Scaffold(
          body: Center(
              child: CircularProgressIndicator()), // Loader during redirection
        );
      },
      //   return Scaffold(
      //     body: Center(
      //       child: Text('Please log in to access this page.'),
      //     ),
      //   );
      // },
    );
  }
}
