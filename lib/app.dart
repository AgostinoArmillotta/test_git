import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("La mia lista"),
        ),
        body: ListView(
          children: [
            Text("Elemento 1"),
            Text("Elemento 2"),
            Text("Elemento 3"),
          ],
        ),
      ),
    ),
  );
}