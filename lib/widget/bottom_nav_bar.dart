// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:task_manager_app/bloc/event/auth_event.dart';
// import '../bloc/auth_bloc.dart';

// class BottomNavBar extends StatelessWidget {
//   final Map<String, dynamic> userInfo;

//   BottomNavBar({required this.userInfo});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.info),
//           label: 'About',
//         ),
//         BottomNavigationBarItem(
//           icon: CircleAvatar(
//             child: Text(userInfo['firstName'][0]),
//           ),
//           label: userInfo['firstName'],
//         ),
//       ],
//       onTap: (index) {
//         if (index == 0) {
//           Navigator.pushReplacementNamed(context, '/home');
//         } else if (index == 1) {
//           Navigator.pushReplacementNamed(context, '/about');
//         } else if (index == 2) {
//           showModalBottomSheet(
//             context: context,
//             builder: (_) => LogoutModal(),
//           );
//         }
//       },
//     );
//   }
// }

// class LogoutModal extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('Are you sure you want to logout?'),
//           SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   context.read<AuthBloc>().add(AuthLogout() as AuthEvent);
//                   Navigator.pushReplacementNamed(context, '/');
//                 },
//                 child: Text('Logout'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('Cancel'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AuthLogout {}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/bloc/event/auth_event.dart';
import 'package:task_manager_app/services/auth_service.dart';
import '../bloc/auth_bloc.dart';

class BottomNavBar extends StatelessWidget {
  final Map<String, dynamic> userInfo;

  BottomNavBar({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About',
        ),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            child: Text(userInfo['username'][0]),
          ),
          label: userInfo['username'],
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (index == 1) {
          Navigator.pushReplacementNamed(context, '/about');
        } else if (index == 2) {
          showModalBottomSheet(
            context: context,
            builder: (_) => LogoutModal(),
          );
        }
      },
    );
  }
}

class LogoutModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Are you sure you want to logout?'),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await AuthService.logout();
                  Navigator.of(context).pushReplacementNamed('/');
                  // context.read<AuthBloc>().add(AuthLogout() as AuthEvent);
                  // Navigator.pushReplacementNamed(context, '/');
                },
                child: Text('Logout'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AuthLogout {}
