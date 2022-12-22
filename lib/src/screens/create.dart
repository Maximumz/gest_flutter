// Copyright 2021, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:gest_flutter/src/screens/notables.dart';
import 'package:http/http.dart' as http;
import '../data/user.dart';

class FormData {
  final String title;
  final String content;
  final String author;

  FormData(this.title, this.content, this.author);
}

class CreateScreen extends StatefulWidget {

  const CreateScreen({
    super.key,
  });

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _authorController = TextEditingController();

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
                  Text('Create',
                      style: Theme.of(context).textTheme.headlineMedium),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Content'),
                    controller: _contentController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Author'),
                    controller: _authorController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () async {
                        createNotable(FormData(
                            _titleController.value.text,
                            _contentController.value.text,
                            _authorController.value.text), context);
                      },
                      child: const Text('Create'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

    Future<void> createNotable(formData, context) async {
      dynamic user = await SessionManager().get("User");
      dynamic accessToken = User.fromJson(user).accessToken;
      
      final response = await http.post(
          Uri.parse('https://gest-backend.onrender.com/api/notables/create'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken'
          },
          body: jsonEncode(<String, String>{
            'title': formData.title,
            'content': formData.content,
            'author': formData.author,
          }),
        );
        if (response.statusCode == 201) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          showAlertDialog(context);
        }
    }

  showAlertDialog(BuildContext context) {  
    // Create button  
    Widget okButton = TextButton(  
      child: const Text("OK"),  
      onPressed: () {  
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotablessScreen()),
        );
      },  
    );  

    // Create AlertDialog  
    AlertDialog alert = AlertDialog(  
      title: const Text("Success"),  
      content: const Text("Your quote has been saved"),  
      actions: [  
        okButton,  
      ],  
    );  

  // show the dialog  
    showDialog(  
    context: context,  
    builder: (BuildContext context) {  
        return alert;  
      },  
    );  
  }
}