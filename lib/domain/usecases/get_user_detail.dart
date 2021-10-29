import 'package:dartz/dartz.dart';
import 'package:github_users_flutter/core/failures.dart';
import 'package:github_users_flutter/core/usecase.dart';
import 'package:github_users_flutter/domain/entities/user_detail.dart';
import 'package:github_users_flutter/domain/repositories/github_user_repository.dart';

class GetUserDetail implements UseCase<UserDetail, GetUserDetailParams> {
  final GitHubUserRepository repository;

  GetUserDetail(this.repository);

  @override
  Future<Either<Failure, UserDetail>> call(GetUserDetailParams params) async {
    return await repository.getUserDetail(params.userName);
  }
}

class GetUserDetailParams {
  final String userName;

  GetUserDetailParams(this.userName);
}
