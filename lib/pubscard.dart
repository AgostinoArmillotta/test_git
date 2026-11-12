import 'pub.dart';
import 'package:flutter/material.dart';


class PubCard extends StatelessWidget {

  PubCard(this.pub);
  final Pubs pub;

  Widget build(BuildContext context) {
    return Card(
          child: ListTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.transparent,
              backgroundImage:
              NetworkImage('http://localhost:1337${pub.picture.URL}')),
            title: Text(pub.name),
            subtitle: Text(pub.address),
            trailing: Text('${pub.avgPrice} €'),
          ),
        );
      }
}