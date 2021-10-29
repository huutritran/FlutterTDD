import 'package:equatable/equatable.dart';

class UserDetail extends Equatable {
  final num id;
  final String name;
  final String avatarUrl;
  final int publicRepos;
  final int followers;
  final int following;
  final String html;
  final String? location;
  final String? displayName;
  final String? email;
  final String? bio;

  const UserDetail({required this.id,
    required this.name,
    required this.avatarUrl,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.html,
    this.location,
    this.displayName,
    this.email,
    this.bio});

  @override
  List<Object?> get props =>
      [
        id,
        name,
        avatarUrl,
        publicRepos,
        followers,
        following,
        html,
        location,
        displayName,
        email,
        bio
      ];
}
