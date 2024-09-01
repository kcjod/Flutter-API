import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PutRoute extends StatefulWidget{
  const PutRoute({super.key});

  @override
  State<StatefulWidget> createState() {
    return PutState();
  }
}

class PutState extends State<PutRoute>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GET ROUTE"),
      ),
      body: Container(
        child: Text("This is get page"),
      ),
    );
  }
}