// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class Credentials {
  final String name;
  final String email;
  final String username;
  final String password;

  Credentials(this.name, this.email, this.username, this.password);
}

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Card(
            child: Container(
              constraints: BoxConstraints.loose(const Size(600, 600)),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Sign up',
                      style: Theme.of(context).textTheme.headlineMedium),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Name'),
                    controller: _nameController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    controller: _emailController,
                  ),
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
                    onPressed: () => showDialog<String>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Alert!'),
                          content: const Text('The alert description goes here.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                      //() async {
                        // widget.onSignUp(Credentials(
                        //     _nameController.value.text,
                        //     _emailController.value.text,
                        //     _usernameController.value.text,
                        //     _passwordController.value.text));
                      //},
                      child: const Text('Sign up'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}