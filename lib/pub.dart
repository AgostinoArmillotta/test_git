import 'package:json_annotation/json_annotation.dart';
import '../pubpicture.dart';
part 'pub.g.dart';

@JsonSerializable(explicitToJson: true)
class Pubs
{
  final int id;
  final String name;
  final String address;
  final PubPicture picture; 
  final String avgPrice;

  Pubs({required this.id, required this.name, required this.address, required this.picture, required this.avgPrice});  

  factory Pubs.fromJson(Map<String, dynamic> json) => _$PubsFromJson(json);

  Map<String, dynamic> toJson() => _$PubsToJson(this);
}