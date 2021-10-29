import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:github_users_flutter/core/failures.dart';
import 'package:github_users_flutter/core/usecase.dart';
import 'package:github_users_flutter/domain/entities/user_paged_item.dart';
import 'package:github_users_flutter/domain/repositories/github_user_repository.dart';

class SearchUsers implements UseCase<UserPagedItem,SearchUsersParam>{
  final GitHubUserRepository repository;

  SearchUsers(this.repository);

  @override
  Future<Either<Failure, UserPagedItem>> call(SearchUsersParam param) async {
    return await repository.searchUsers(param.keywords, param.page);
  }
}

class SearchUsersParam extends Equatable {
  final String keywords;
  final int page;

  const SearchUsersParam(this.keywords, this.page);

  @override
  List<Object?> get props => [keywords, page];
}