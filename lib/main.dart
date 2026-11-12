import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trying_flutter/pub.dart';
import 'package:trying_flutter/pubpicture.dart';
import 'package:trying_flutter/pubscard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.yellowAccent),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  
  const MyHomePage({super.key,required this.title});
  final String title;
  @override
  State<MyHomePage> createState() =>
      _MyHomePageState();
  }

  class _MyHomePageState extends State<MyHomePage> {
    List<Pubs> pubs = [];
    List<PubPicture> pubpicture = [];

    void initstate(){
      super.initState();
      fetchAffordablePubs();
    }
  Future<void> fetchAffordablePubs() async {
  final url = Uri.parse(
    'http://localhost:1337/api/pubs/affordable?maxPrice=25',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    pubs.add(Pubs.fromJson(data));
    pubpicture.add(PubPicture.fromJson(data));
  } else {
    print('Errore: ${response.statusCode}');
    print(response.body);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: 
      ListView.builder(
              itemCount: pubs.length,
              itemBuilder: (context, index) {
                return PubCard(pubs[index]);
              }
            ),
    ),
  }
}