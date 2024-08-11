// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:task_manager_app/widget/bottom_nav_bar.dart';
// import 'dart:convert';

// class HomeScreen extends StatelessWidget {
//   final _secureStorage = FlutterSecureStorage();

//   Future<Map<String, dynamic>> _getUserInfo() async {
//     String? userInfoString = await _secureStorage.read(key: 'userInfo');
//     return json.decode(userInfoString!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, dynamic>>(
//       future: _getUserInfo(),
//       builder: (context, snapshot) {
//         print(snapshot.);
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(body: Center(child: CircularProgressIndicator()));
//         }

//         if (snapshot.hasData) {
//           final userInfo = snapshot.data!;
//           return Scaffold(
//             appBar: AppBar(title: Text('Home')),
//             body: Center(child: Text('Welcome, ${userInfo['firstName']}!')),
//             bottomNavigationBar: BottomNavBar(userInfo: userInfo),
//           );
//         }

//         return Scaffold(
//           body: Center(child: Text('Failed to load user information')),
//         );
//       },
//     );
//   }
// }

// home_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/screens/task_list.dart';
import 'package:task_manager_app/services/auth_service.dart';
import 'package:task_manager_app/services/route_guard.dart';
import 'package:task_manager_app/widget/bottom_nav_bar.dart';
import 'package:task_manager_app/widget/task_form.dart';

class HomeScreen extends StatelessWidget {
  Future<Map<String, dynamic>> _fetchUserInfo() async {
    final userInfo = await AuthService.getLoginInfo();

    if (userInfo == null) {
      throw Exception('No user information available.');
    }
    return userInfo;
  }

  @override
  Widget build(BuildContext context) {
    return RouteGuard(
      redirectTo: '/',
      requireLogin: true,
      child: FutureBuilder<Map<String, dynamic>>(
        future: _fetchUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.hasData) {
            final userInfo = snapshot.data!;

            return Scaffold(
              appBar: AppBar(title: Text('Task Management')),
              body: TaskList(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => TaskForm(),
                  );
                },
                child: Icon(Icons.add),
              ),
              // appBar: AppBar(title: Text('Home')),
              // body: Center(
              //     child: Text('Welcome, ${userInfo['userInfo']['username']}!')),
              bottomNavigationBar: BottomNavBar(userInfo: userInfo['userInfo']),
            );
          }

          return Scaffold(
            body: Center(child: Text('Failed to load user information')),
          );
        },
      ),
    );
  }
}
