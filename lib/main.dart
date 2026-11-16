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
      home: const EverisFridayPage (title: 'Flutter Demo Home Page'),
    );
  }
}
class EverisFridayPage extends StatefulWidget {
  
  const EverisFridayPage ({super.key,required this.title});
  final String title;
  @override
  State<EverisFridayPage> createState() =>
      _EverisFridayState();
  }

  class _EverisFridayState extends State<EverisFridayPage> {
    final List<Pubs> pubs = <Pubs>[];
    late Future<bool> futurePubs;
    
    @override
    void initState(){
      super.initState();
      futurePubs = fetchAffordablePubs(pubs);
    }

  Future<bool> fetchAffordablePubs(pubs) async {
    final url = Uri.parse(
      'http://localhost:1337/api/pubs/affordable?maxPrice=25',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      for (var pubData in data) {
        pubs.add(Pubs.fromJson(pubData));
      }
      print(pubs.length);
      return true;
    } else {

      print('Errore: ${response.statusCode}');
      print('${response.body}');
      return false;
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:Center(
        child: _buildPubs(),
      )
    );
  }
  Widget _buildPubs() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none ||
            // ignore: unnecessary_null_comparison
            projectSnap.hasData == false) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Text("ops there is no data or connection")
            ],
          );
        }
        return ListView.builder(
          itemCount: pubs.length,
          itemBuilder: (context, index) {
            return PubCard(pubs[index]);
          },
        );
      },
      future: futurePubs,
    );
  }
}