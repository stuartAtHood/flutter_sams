import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EditableTextScreen(),
    );
  }
}

class EditableTextScreen extends StatefulWidget {
  @override
  _EditableTextScreenState createState() => _EditableTextScreenState();
}

class _EditableTextScreenState extends State<EditableTextScreen> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editable Text Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Editable Text:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Enter your text here',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retrieve the text from the TextField
                String text = _textEditingController.text;
                // You can use 'text' as needed, e.g., save it or display it.
                print('Entered text: $text');
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
}
