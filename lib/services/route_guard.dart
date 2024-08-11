import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RouteGuard extends StatelessWidget {
  final Widget child;
  final String redirectTo; // The route to redirect to if conditions are met
  final bool
      requireLogin; // Whether the page requires the user to be logged in or not

  const RouteGuard({
    required this.child,
    required this.redirectTo,
    this.requireLogin = true,
  });

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasData) {
          final isLoggedIn = snapshot.data!;
          // print({isLoggedIn,redirectTo,requireLogin});

          if (requireLogin && !isLoggedIn) {
            // If the page requires login and the user is not logged in, redirect
            Future.microtask(() {
              Navigator.of(context).pushReplacementNamed(redirectTo);
            });
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (!requireLogin && isLoggedIn) {
            // If the page should not be accessed when logged in, redirect
            Future.microtask(() {
              Navigator.of(context).pushReplacementNamed(redirectTo);
            });
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
        }

        // If conditions are met, display the page
        return child;
      },
    );
  }
}
