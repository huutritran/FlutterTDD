import 'package:equatable/equatable.dart';

class User extends Equatable {
  final num id;
  final String name;
  final String avatarUrl;
  final int score;
  final String html;

  const User({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.score,
    required this.html,
  });

  @override
  List<Object?> get props => [id, name, avatarUrl, score, html];
}
