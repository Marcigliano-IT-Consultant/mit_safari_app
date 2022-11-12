import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:posts_repository/posts_repository.dart' as post_repository;

part 'post.g.dart';

@JsonSerializable()
class Post extends Equatable {
  const Post({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  factory Post.fromRepository(post_repository.Post post) {
    return Post(
      body: post.body,
      id: post.id,
      title: post.title,
    );
  }

  static const empty = Post(
    id: 0,
    body: '',
    title: '',
  );

  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [id, title, body];

  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post copyWith({
    int? id,
    String? title,
    String? body,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
