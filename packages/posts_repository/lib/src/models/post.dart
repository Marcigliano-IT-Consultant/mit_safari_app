import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  const Post({
    required this.id, 
    required this.title, 
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [id, title, body];
}
