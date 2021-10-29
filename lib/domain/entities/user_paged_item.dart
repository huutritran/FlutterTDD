import 'package:equatable/equatable.dart';
import 'package:github_users_flutter/domain/entities/user.dart';

class UserPagedItem extends Equatable {
  final List<User> users;
  final int totalItems;

  const UserPagedItem(this.users, this.totalItems);

  @override
  List<Object?> get props => [totalItems, users];
}