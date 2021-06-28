import 'dart:math';

import 'package:flutter/material.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return Container(
              color:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)],
              height: 150.0);
        },
      ),
    );
  }
}
