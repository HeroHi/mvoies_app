import 'package:json_annotation/json_annotation.dart';

part 'genre_dm.g.dart';

@JsonSerializable()
class GenreDM {
  final int id;
  final String name;

  GenreDM({
    required this.id,
    required this.name,
  });

  factory GenreDM.fromJson(Map<String, dynamic> json) => _$GenreDMFromJson(json);

  Map<String, dynamic> toJson() => _$GenreDMToJson(this);
}
