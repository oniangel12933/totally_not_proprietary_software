// import 'dart:convert';
//
// import 'package:involio/gen/involio_api.swagger.dart';
//
// class PostService {
//   String baseURL = 'https://jsonplaceholder.typicode.com';
//   static LocalStorage storage = LocalStorage('post');
//   var stopwatch = Stopwatch()..start();
//
//   Future<UserResponse> getUser() async {
//     var post = await getUserFromCache();
//     if (post == null) {
//       return getUserFromAPI();
//     }
//     return post;
//   }
//
//   Future<UserResponse> getUserFromAPI() async {
//     UserResponse post = await fetchPost();
//     post.fromCache = false; //to indicate post is pulled from API
//     savePost(post);
//     return post;
//   }
//
//   Future<UserResponse> getUserFromCache() async {
//     await storage.ready;
//     Map<String, dynamic> data = storage.getItem('post');
//     if (data == null) {
//       return null;
//     }
//     UserResponse post = UserResponse.fromJson(data);
//     post.fromCache = true; //to indicate post is pulled from cache
//     return post;
//   }
//
//   void savePost(UserResponse post) async {
//     await storage.ready;
//     storage.setItem("post", post);
//   }
//
//   Future<UserResponse> fetchPost() async {
//     String _endpoint = '/posts/1';
//
//     dynamic post = await _get(_endpoint);
//     if (post == null) {
//       return null;
//     }
//     UserResponse p = UserResponse.fromJson(post);
//     return p;
//   }
//
//   Future _get(String url) async {
//     String endpoint = '$baseURL$url';
//     try {
//       final response = await http.get(endpoint);
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (err) {
//       throw Exception(err);
//     }
//   }
// }
