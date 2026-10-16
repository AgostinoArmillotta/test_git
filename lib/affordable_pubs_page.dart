import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



class AffordablePubsPage extends StatefulWidget {
  
  const AffordablePubsPage({super.key});

  @override
  State<AffordablePubsPage> createState() =>
      _AffordablePubsPageState();
  }

  class _AffordablePubsPageState extends State<AffordablePubsPage> {
    List<dynamic> pubs = [];

    Future<void> fetchAffordablePubs() async {
  final url = Uri.parse(
    'http://localhost:1337/api/pubs/affordable?maxPrice=15',
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pub eccocccococo'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: fetchAffordablePubs,
            child: const Text('Carica pub'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pubs.length,
              itemBuilder: (context, index) {
                final pub = pubs[index];

                return Card(
                  child: ListTile(
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