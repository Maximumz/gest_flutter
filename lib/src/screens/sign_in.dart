// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);
}

class SignInScreen extends StatefulWidget {
  final ValueChanged<Credentials> onSignIn;

  const SignInScreen({
    required this.onSignIn,
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Card(
            child: Container(
//              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Card(
                        elevation: 10,
                        child: Image.asset('assets/images/logo-color.png', width: 200, height: 200),
                      ),
                      const Padding(padding: EdgeInsets.all(16)),
                    ],
                  ),
                  Text('Sign in',
                      style: Theme.of(context).textTheme.headlineMedium),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Username'),
                    controller: _usernameController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () async {
                        widget.onSignIn(Credentials(
                            _usernameController.value.text,
                            _passwordController.value.text));
                      },
                      child: const Text('Sign in'),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(16),
                  //   child: TextButton(
                  //     onPressed: () {
                  //       RouteStateScope.of(context).go('/signup');
                  //     },
                  //     child: const Text('Sign up'),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
}