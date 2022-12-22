// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:http/http.dart' as http;
import 'data/user.dart';

/// A mock authentication service
class GestAuth extends ChangeNotifier {
  bool _signedIn = false;

  bool get signedIn => _signedIn;

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    // Sign out.
    _signedIn = false;
    await SessionManager().destroy();
    notifyListeners();
  }

  Future<bool> signIn(String username, String password) async {
      final response = await http.post(
        Uri.parse('https://gest-backend.onrender.com/preauth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        var userData = jsonDecode(response.body);
        await SessionManager().set('User', User.fromJson(userData['user']));
        _signedIn = true;
        notifyListeners();
        return _signedIn;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        _signedIn = false;
        await SessionManager().destroy();
        return _signedIn;
      }
  }

  @override
  bool operator ==(Object other) =>
      other is GestAuth && other._signedIn == _signedIn;

  @override
  int get hashCode => _signedIn.hashCode;
}

class GestAuthScope extends InheritedNotifier<GestAuth> {
  const GestAuthScope({
    required super.notifier,
    required super.child,
    super.key,
  });

  static GestAuth of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<GestAuthScope>()!
      .notifier!;
}