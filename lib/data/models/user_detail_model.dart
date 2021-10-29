import 'package:github_users_flutter/domain/entities/user_detail.dart';

class UserDetailModel extends UserDetail {
  const UserDetailModel(
      {required num id,
      required String name,
      required String avatarUrl,
      required int publicRepos,
      required int followers,
      required int following,
      required String html,
      String? location,
      String? displayName,
      String? email,
      String? bio})
      : super(
            id: id,
            name: name,
            avatarUrl: avatarUrl,
            publicRepos: publicRepos,
            followers: followers,
            following: following,
            html: html,
            location: location,
            displayName: displayName,
            email: email,
            bio: bio);

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
        id: json['id'],
        name: json['login'],
        avatarUrl: json['avatar_url'],
        publicRepos: json['public_repos'],
        followers: json['followers'],
        following: json['following'],
        html: json['html_url'],
        location: json['location'],
        displayName: json['name'],
        email: json['email'],
        bio: json['bio']);
  }
}
