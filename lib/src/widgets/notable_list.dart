// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../data.dart';

class NotableList extends StatelessWidget {
  final List<Notable> notable;
  final ValueChanged<Notable>? onTap;

  const NotableList({
    required this.notable,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: notable.length,
        itemBuilder: (BuildContext context, int index) => ListTile(
          tileColor: index == 0 ? Colors.lightGreen[700] : Colors.blueGrey[50],
          textColor: index == 0 ? Colors.white : Colors.blueGrey[800],
          contentPadding: const EdgeInsets.all(15),
          title: Text(
            style: const TextStyle(
              fontSize: 20.0,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w700,
            ),
            notable[index].title,
          ),
          subtitle: Text(
            '${notable[index].content} - ${notable[index].author}',
          ),
          onTap: onTap != null ? () => onTap!(notable[index]) : null,
        ), 
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
}