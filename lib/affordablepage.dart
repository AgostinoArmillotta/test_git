import 'package:flutter/material.dart';
import 'package:trying_flutter/pub.dart';
import 'dart:convert';
import 'package:trying_flutter/pubscard.dart';
import 'package:http/http.dart' as http;

class Affordablepage extends StatefulWidget {

  const Affordablepage ({super.key});

  State<Affordablepage> createState() =>
      _AffordablepageState();
      
}


class _AffordablepageState extends State<Affordablepage> {
  List<dynamic> pubs = [];
  late Future<bool> futurePubs;

  late double AvgPrice = 500;

  @override
  void initState(){

    super.initState();
    futurePubs = fetchAffordablePubs(pubs, AvgPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Affordable Pubs')),
      body: Column(
        children: [
          Slider(
            value: AvgPrice,
            min: 0,
            max: 250,
            onChanged: (nuovoValore) {
              setState(() {
                AvgPrice = nuovoValore;
                print(AvgPrice);
                pubs.clear();
                futurePubs = fetchAffordablePubs(pubs, AvgPrice);
                
              });
            },
          ),
          Expanded(
            child: _buildPubs(),
          ),
        ],
      ),
    );
  }

  Widget _buildPubs() {
      return FutureBuilder(
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none || projectSnap.hasData == false) {
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

  Future<bool> fetchAffordablePubs(pubs, double AvgPrice) async {
      final url = Uri.parse(
        'http://localhost:1337/api/pubs/affordable?maxPrice=$AvgPrice',
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
}