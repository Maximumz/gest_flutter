// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

import '../data.dart';

class NotableDetailsScreen extends StatelessWidget {
  final Notable? notable;

  const NotableDetailsScreen({
    super.key,
    this.notable,
  });

  @override
  Widget build(BuildContext context) {
    if (notable == null) {
      return const Scaffold(
        body: Center(
          child: Text('No notable found.'),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(notable!.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              notable!.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              notable!.content,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              notable!.author,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextButton(
              child: const Text('View notable (Push)'),
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (context) =>
                        NotableDetailsScreen(notable: notable),
                  ),
                );
              },
            ),
            Link(
              uri: Uri.parse('/notable/${notable!.id}'),
              builder: (context, followLink) => TextButton(
                onPressed: followLink,
                child: const Text('View notable (Link)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}