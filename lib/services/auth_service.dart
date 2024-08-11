import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> storeLoginInfo(
      String token, Map<String, dynamic> userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('userInfo', jsonEncode(userInfo));
  }

  static Future<Map<String, dynamic>?> getLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final userInfoString = prefs.getString('userInfo');

    // print(userInfoString);

    if (token != null && userInfoString != null) {
      return {
        'token': token,
        'userInfo': jsonDecode(userInfoString),
      };
    }
    return null;
  }

  // static Future<Map<String, dynamic>?> getLoginInfo() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final userInfoString = prefs.getString('userInfo');

  //   print('Stored userInfoString: $userInfoString');

  //   if (token != null && userInfoString != null) {
  //     try {
  //       final userInfo = jsonDecode(userInfoString);
  //       return {
  //         'token': token,
  //         'userInfo': userInfo,
  //       };
  //     } catch (e) {
  //       print('Error decoding userInfoString: $e');
  //       return null; // Or handle the error accordingly
  //     }
  //   }
  //   return null;
  // }
  // static Future<Map<String, dynamic>?> getLoginInfo() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final userInfoString = prefs.getString('userInfo');

  //   print('Stored userInfoString: $userInfoString');
  //   final userInfo = jsonDecode(userInfoString!);
  //   print('Stored : $userInfo');

  //   // if (token != null && userInfoString != null) {
  //   //   try {
  //   //     // Correctly decode the JSON string
  //   //     final userInfo = jsonDecode(userInfoString);
  //   //     return {
  //   //       'token': token,
  //   //       'userInfo': userInfo,
  //   //     };
  //   //   } catch (e) {
  //   //     print('Error decoding userInfoString: $e');
  //   //     return null; // Handle the error accordingly
  //   //   }
  //   // }
  //   // return userInfo
  //   //     ? {
  //   //         'token': token,
  //   //         'userInfo': userInfo,
  //   //       }
  //   //     : null;
  //   return null;
  // }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await prefs.remove('token');
    await prefs.remove('userInfo');
  }
}
