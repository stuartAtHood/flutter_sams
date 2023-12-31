import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/*
 * New screen for showing/editing a client's details
 * It is created from the main screen and must have the client id
 * passed in to its constructor.
 * 
 * Action: on submit it will update the client details in SAMS
 */

class EditableTextScreen extends StatefulWidget {
  var id;
  var name;

  EditableTextScreen(id, String name) {
    this.id = id;
    this.name = name;
  }

  @override
  _EditableTextScreenState createState() => _EditableTextScreenState(id, name);
}

class _EditableTextScreenState extends State<EditableTextScreen> {

  var id;
  var name;

  _EditableTextScreenState(id, name) {
    this.id = id;
    this.name = name;
  }

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold (
      appBar: AppBar(
        title: Text('Client ${this.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Client: ${this.id}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _textEditingController = TextEditingController(text: name),
              decoration: InputDecoration(
                hintText: '$name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retrieve the text from the TextField
                String text = _textEditingController.text;
                // You can use 'text' as needed, e.g., save it or display it.
                print('Entered text: $text');
                updateClient(this.id, text);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the TextEditingController when it's no longer needed.
    _textEditingController.dispose();
    super.dispose();
  }
  
  void updateClient(id, String name) async {
    // update client
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
    }; // Replace with your data

    final Uri url = Uri.parse('http://localhost:9080/dynamic/updateClient');

    try {
      final response = await http.post(
        url,
        body: data,
      );

      if (response.statusCode == 200) {
        // Request was successful, handle the response data
        // print('Response Data: ${response.body}');
      } 
    } catch (e) {
      // An error occurred
      print('Error: $e');
    }
  }
}
