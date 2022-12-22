// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../auth.dart';
import '../data.dart';
import '../routing.dart';
import '../screens/sign_in.dart';
//import '../screens/sign_up.dart';
import '../widgets/fade_transition_page.dart';
import 'notable_details.dart';
import 'scaffold.dart';

/// Builds the top-level navigator for the app. The pages to display are based
/// on the `routeState` that was parsed by the TemplateRouteParser.
class GestNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const GestNavigator({
    required this.navigatorKey,
    super.key,
  });

  @override
  State<GestNavigator> createState() => _GestNavigatorState();
}

class _GestNavigatorState extends State<GestNavigator> {
  final _signInKey = const ValueKey('Sign in');
  final _signUpKey = const ValueKey('Sign up');
  final _scaffoldKey = const ValueKey('App scaffold');
  final _notableDetailsKey = const ValueKey('Notable details screen');

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final authState = GestAuthScope.of(context);
    final pathTemplate = routeState.route.pathTemplate;

    Notable? selectedNotable;
    if (pathTemplate == '/notable/:notableId') {
      selectedNotable = notablesInstance.allNotables.firstWhere(
          (b) => b.id.toString() == routeState.route.parameters['notableId']);
    }

    return Navigator(
      key: widget.navigatorKey,
      onPopPage: (route, dynamic result) {
        // When a page that is stacked on top of the scaffold is popped, display
        // the /notables tab in GestScaffold.
        if (route.settings is Page &&
            (route.settings as Page).key == _notableDetailsKey) {
          routeState.go('/notables');
        }

        return route.didPop(result);
      },
      pages: [
        if (routeState.route.pathTemplate == '/signin')
          // Display the sign in screen.
          FadeTransitionPage<void>(
            key: _signInKey,
            child: SignInScreen(
              onSignIn: (credentials) async {
                var signedIn = await authState.signIn(
                    credentials.username, credentials.password);
                if (signedIn) {
                  await routeState.go('/notables');
                }
              },
            ),
          )
        // else if(routeState.route.pathTemplate == '/signup')
        //   // Display the sign up screen.
        //   FadeTransitionPage<void>(
        //     key: _signUpKey,
        //     child: SignUpScreen(
        //       onSignUp: (credentials) async {
        //         await routeState.go('/signup');
        //       },
        //     ),
        //   )
        else ...[
          // Display the app
          FadeTransitionPage<void>(
            key: _scaffoldKey,
            child: const GestScaffold(),
          ),
          // Add an additional page to the stack if the user is viewing a notable
          if (selectedNotable != null)
            MaterialPage<void>(
              key: _notableDetailsKey,
              child: NotableDetailsScreen(
                notable: selectedNotable,
              ),
            )
        ],
      ],
    );
  }
}