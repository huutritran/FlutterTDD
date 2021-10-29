import 'package:github_users_flutter/domain/entities/user.dart';
import 'package:github_users_flutter/domain/entities/user_paged_item.dart';

class UserModel extends User {
  const UserModel(
      {required num id,
      required String name,
      required String avatarUrl,
      required int score,
      required String html})
      : super(
            id: id, name: name, avatarUrl: avatarUrl, score: score, html: html);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['login'],
        avatarUrl: json['avatar_url'],
        score: (json['score']).toInt(),
        html: json['html_url']);
  }
}

class SearchUserModel extends UserPagedItem{
  final int totalCount;
  final List<UserModel> items;
  const SearchUserModel(
      {required this.totalCount, required this.items}) : super(items, totalCount);

  factory SearchUserModel.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<UserModel> userList = list.map((u) => UserModel.fromJson(u)).toList();

    return SearchUserModel(totalCount: json['total_count'], items: userList);
  }
}
