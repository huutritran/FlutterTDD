import 'package:dartz/dartz.dart';
import 'package:github_users_flutter/core/exceptions.dart';
import 'package:github_users_flutter/core/failures.dart';
import 'package:github_users_flutter/core/flatform/network_info.dart';
import 'package:github_users_flutter/data/datasources/github_user_remote_data_source.dart';
import 'package:github_users_flutter/domain/entities/user_detail.dart';
import 'package:github_users_flutter/domain/entities/user_paged_item.dart';
import 'package:github_users_flutter/domain/repositories/github_user_repository.dart';

class GitHubUserRepositoryImpl implements GitHubUserRepository {
  final GithubRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  GitHubUserRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, UserDetail>> getUserDetail(String userName) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getUserDetail(userName));
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(NetworkFailure());
  }

  @override
  Future<Either<Failure, UserPagedItem>> searchUsers(
      String keywords, int page) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.searchUsers(keywords, page));
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(NetworkFailure());
  }
}
