import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testapp/models/post.dart';
import 'package:http/http.dart' as http;

class GetRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GetState();
  }
}

class GetState extends State<GetRoute> {
  List<Welcome> _products = [];
  bool _isLoading = false;
  String? _error;

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    final url = Uri.parse('https://fakestoreapi.com/products');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        final List<Welcome> data = jsonResponse.map((json) => Welcome.fromJson(json)).toList();

        setState(() {
          _products = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load data';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GET ROUTE"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text('Error: $_error'))
          : _products.isEmpty
          ? Center(
        child: ElevatedButton(
          onPressed: getData,
          child: const Text("Get Data"),
        ),
      )
          : ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            leading: Image.network(product.image, width: 50, height: 50),
            title: Text(product.title),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
