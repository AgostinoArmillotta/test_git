import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      home: const AffordablePubsPage(title: 'Flutter Demo Home Page'),
    );
  }
}
class AffordablePubsPage extends StatefulWidget {
  
  const AffordablePubsPage({super.key,required this.title});
  final String title;

  @override
  State<AffordablePubsPage> createState() =>
      _AffordablePubsPageState();
  }

  class _AffordablePubsPageState extends State<AffordablePubsPage> {
    List<dynamic> pubs = [];
  
  Future<void> fetchAffordablePubs() async {
  final url = Uri.parse(
    'http://localhost:1337/api/pubs/affordable?maxPrice=25',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    setState(() {
      pubs = data;
    });
  } else {
    print('Errore: ${response.statusCode}');
    print(response.body);
  }
}

  @override
  Widget build(BuildContext context) {
    fetchAffordablePubs();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pubs.length,
              itemBuilder: (context, index) {
                final pub = pubs[index];

                return Card(
                  child: ListTile(
                    leading: Image.asset('asset/images/Pubs1.jpg',), //
                    title: Text(pub['name']),
                    subtitle: Text(pub['address']),
                    trailing: Text('${pub['avgprice']} €'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}