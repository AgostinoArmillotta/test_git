import 'pub.dart';
import 'package:flutter/material.dart';


class PubCard extends StatelessWidget {

  PubCard(this.pubs);
  final List<Pubs> pubs;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                
                return Card(
                  child: ListTile(
                    /*leading: Image.asset(pubs[index].picture.URL,), //
                    title: Text(pubs[index].name),
                    subtitle: Text(pubs[index].address),
                    trailing: Text('${pubs[index].avgPrice} €'),*/
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