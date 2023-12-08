import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

void main() async {
  runApp(MyApp());
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
  String clientText = 'no client';
  List<dynamic> clientMap = [];
  List<Map<String, dynamic>> decodedJson = [];

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
      final clients = await http.get(Uri.parse('http://localhost:9080/dynamic/clients'),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
      // final response = await Dio().get('http://127.0.0.1:9080/dynamic/version');
      print("response ...");
      print(response);

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the text
        setState(() {
          var body = response.body.toString();
          Map<String, dynamic> jsonMap = json.decode(body);
          fetchedText = jsonMap['message'];
          print(fetchedText);
          clientText = clients.body.toString();
          decodedJson = (json.decode(clientText) as List)
              .map((dynamic item) => item as Map<String, dynamic>)
              .toList();
  
          for (var entry in decodedJson) {
            int id = entry['id'];
            String name = entry['name'];
            String account = entry['account'];

            print('ID: $id, Name: $name, Account: $account');
          }
      
          // print(clientMap[0]);
        });
      } 
      else {
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
    // var name = clientMap[0];

    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Text from URL'),
      ),
      body: ListView.builder(
        itemCount: decodedJson.length + 2, // +2 for the additional Text widgets
        itemBuilder: (context, index) {
          if (index == 0) {
            return Text('SAMS');
          } 
          else if (index == 1) {
            return Text(fetchedText);
          }
          else {
            return ListTile(
              title: Text('ID: ${decodedJson[index - 2]['id']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${decodedJson[index - 2]['name']}'),
                  Text('Account: ${decodedJson[index - 2]['account']}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
