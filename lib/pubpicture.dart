import 'package:json_annotation/json_annotation.dart';
part 'pubpicture.g.dart';

@JsonSerializable(explicitToJson: true)
class PubPicture{
  
  final int id;
  final String name;
  final String URL;

  const PubPicture({required this.id, required this.name, required this.URL});

  factory PubPicture.fromJson(Map<String, dynamic> json) => _$PubPictureFromJson(json);

  Map<String, dynamic> toJson() => _$PubPictureToJson(this);
}