import 'package:json_annotation/json_annotation.dart';

import '../character/character.dart';
import '../info/info.dart';

part 'api_response.g.dart';

@JsonSerializable()
class APIResponse {
  final Info info;
  final List<Character>? results;

  const APIResponse({required this.info, required this.results});

  factory APIResponse.fromJson(Map<String, dynamic> json) =>
      _$APIResponseFromJson(json);

  Map<String, dynamic> toJson() => _$APIResponseToJson(this);
}
