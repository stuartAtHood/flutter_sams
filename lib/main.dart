import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() async {
  // final response = await Dio().get('http://www.google.com');
  // print(response.data.toString());
  runApp(MyApp());
    // final response = await http.get(
    //     Uri.parse('http://localhost:9080/dynamic/version'),
    //     headers: {
    //       "Accept": "application/json",
    //       "Access-Control_Allow_Origin": "*"
    //     });

    // print(response.statusCode);
    // print(response.body);

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fetchedText = 'No data';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:9080/dynamic/version'),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
      // final response = await Dio().get('http://127.0.0.1:9080/dynamic/version');

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the text
        setState(() {
          fetchedText = response.body.toString();
          print(fetchedText);
        });
      } else {
        // If the server did not return a 200 OK response,
        // throw an exception or handle the error accordingly.
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    }
    catch (e) {
      print("error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Text from URL'),
      ),
      body: Center(
        child: Text(fetchedText),
      ),
    );
  }
}
