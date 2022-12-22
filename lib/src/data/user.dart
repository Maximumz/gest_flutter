// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class User {
  final int id;
  final String name;
  final String email;
  final String username;
  final String accessToken;

  const User({ required this.id, required this.name, required this.email, required this.username, required this.accessToken });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = <String, dynamic>{};
    user["id"] = id;
    user["name"] = name;
    user["email"] = email;
    user["username"] = username;
    user["access_token"] = accessToken;
    return user;
  }
}