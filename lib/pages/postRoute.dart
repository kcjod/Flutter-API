import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testapp/models/post.dart';
import 'package:http/http.dart' as http;

class PostRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PostState();
  }
}

class PostState extends State<PostRoute> {
  bool _isLoading = false;
  String? _error;
  String? _responseMessage;

  // Function to post data to the API
  Future<void> postData(Map<String, dynamic> data) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _responseMessage = null;
    });

    final url = Uri.parse('https://fakestoreapi.com/products'); // Replace with your API URL

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _responseMessage = "Data posted successfully: ${response.body}";
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to post data: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error occurred: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POST ROUTE"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text('Error: $_error'))
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Example data to be posted
                Map<String, dynamic> data = {
                  'title': 'Test Product',
                  'price': 19.99,
                  'description': 'A great product',
                  'image': 'https://fakestoreapi.com/img/test.jpg',
                  'category': 'electronics'
                };
                postData(data);
              },
              child: Text("Post Data"),
            ),
            SizedBox(height: 20),
            _responseMessage != null
                ? Text(
              'Response: $_responseMessage',
              textAlign: TextAlign.center,
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
