import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:posts_repository/posts_repository.dart';

/// Exception thrown when postsRequest fails.
class PostRequestFailure implements Exception {}
class PostNotFoundFailure implements Exception {}

class PostsRepository {
  /// {@macro open_meteo_api_client}
  PostsRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrlPosts = 'jsonplaceholder.typicode.com';
  static const _postLimit = 20;

  final http.Client _httpClient;

  Future<List<Post>> getPost([int startIndex = 0]) async {
    final response = await _httpClient.get(
      Uri.https(
        _baseUrlPosts,
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Post.fromJson(
          map,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
