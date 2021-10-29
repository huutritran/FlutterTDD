import 'package:dartz/dartz.dart';
import 'package:github_users_flutter/core/failures.dart';
import 'package:github_users_flutter/domain/entities/user_detail.dart';
import 'package:github_users_flutter/domain/entities/user_paged_item.dart';

abstract class GitHubUserRepository {
  Future<Either<Failure, UserPagedItem>> searchUsers(String keywords, int page);

  Future<Either<Failure, UserDetail>> getUserDetail(String userName);
}
