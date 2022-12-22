// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import "dart:math";
import '../data.dart';
import '../routing.dart';
import '../widgets/notable_list.dart';
import 'create.dart';

class NotablessScreen extends StatefulWidget {
  const NotablessScreen({
    super.key,
  });

  @override
  State<NotablessScreen> createState() => _NotablessScreenState();
}

class _NotablessScreenState extends State<NotablessScreen>
  with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(_handleTabIndexChanged);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await notablesInstance.fetchAllNotables();

        final random = Random();
        var randomNotable = notablesInstance.allNotables[random.nextInt(notablesInstance.allNotables.length)];
        notablesInstance.addNotable(randomNotable);

        setState(() {});
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final newPath = _routeState.route.pathTemplate;
    if (newPath.startsWith('/notables')) {
      _tabController.index = 0;
    } else if (newPath.startsWith('/create')) {
      _tabController.index = 1;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndexChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('GEST - A Notable Deed Or Exploit'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Be Inspired',
                icon: Icon(Icons.quora_outlined),
              ),
              Tab(
                text: 'Create',
                icon: Icon(Icons.gesture),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            NotableList(
              notable: notablesInstance.allNotables,
              onTap: _handleNotableTapped,
            ),
            const CreateScreen(),
          ],
        ),
      );

  RouteState get _routeState => RouteStateScope.of(context);

  void _handleNotableTapped(Notable notable) {
    _routeState.go('/notable/${notable.id}');
  }

  void _handleTabIndexChanged() {
    switch (_tabController.index) {
      case 2:
        _routeState.go('/create');
        break;
      case 1:
      default:
        _routeState.go('/notables');
        break;
    }
  }
}