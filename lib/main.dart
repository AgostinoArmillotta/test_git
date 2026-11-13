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
    @override
    void initState(){
      super.initState();
      fetchAffordablePubs();
    }

  Future<void> fetchAffordablePubs() async {
    final url = Uri.parse(
      'http://localhost:1337/api/pubs/affordable?maxPrice=25',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      int count = 0;
      for (var pubData in data) {
        pubs.add(Pubs.fromJson(pubData));
        print(pubs[count].name);
        print(pubs[count].picture.name);
        print(pubs[count].picture.url);
        count += 1;
      }
      print(pubs.length);

    } else {

      print('moralitos : ' + 'Errore: ${response.statusCode}' + ' micacazzo');
      print('uanm : ' + '${response.body}' + 'oouanmoo : ');

    }
    setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:Center(
        child: 
        ListView.builder(
          itemCount: pubs.length,
          itemBuilder: (context, index) {
            return PubCard(pubs[index]);
          }
        ),
      )
    );
  }
}