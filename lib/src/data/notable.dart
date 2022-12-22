// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class Notable {
  final int id;
  final String title;
  final String content;
  final String author;
  final int userId;

  const Notable({ required this.id, required this.title, required this.content, required this.author, required this.userId });

  factory Notable.fromJson(Map<String, dynamic> json) {
    return Notable(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      author: json['author'],
      userId: json['id'],
    );
  }
}