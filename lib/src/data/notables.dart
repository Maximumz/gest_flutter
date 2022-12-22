// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:gest_flutter/src/data/user.dart';
import 'package:http/http.dart' as http;
import 'notable.dart';

final notablesInstance = Notables();

class Notables {
  late final List<Notable> allNotables = [];

  void addNotable(Notable notable) {
    allNotables.insert(0, notable);
  }

  Future<List<Notable>> fetchAllNotables() async {
    dynamic user = await SessionManager().get("User");
    dynamic accessToken = User.fromJson(user).accessToken;

    final response = await http.post(
      Uri.parse('https://gest-backend.onrender.com/api/notables/fetchAll'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $accessToken'
      },
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      final data = jsonDecode(response.body);

      for (var notable in data) {
        addNotable(Notable.fromJson(notable));
      }

      return allNotables;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return allNotables;
    }
  }
}