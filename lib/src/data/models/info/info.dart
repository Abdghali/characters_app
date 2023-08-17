import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

@JsonSerializable()
class Info {
  int count;
  int pages;
  String? next;
  String? prev;

  Info(
      {required this.count,
      required this.pages,
      required this.next,
      required this.prev});

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
