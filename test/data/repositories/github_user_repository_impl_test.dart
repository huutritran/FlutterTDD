import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_users_flutter/core/exceptions.dart';
import 'package:github_users_flutter/core/failures.dart';
import 'package:github_users_flutter/core/flatform/network_info.dart';
import 'package:github_users_flutter/data/datasources/github_user_remote_data_source.dart';
import 'package:github_users_flutter/data/models/user_detail_model.dart';
import 'package:github_users_flutter/data/models/user_model.dart';
import 'package:github_users_flutter/data/repositories/github_user_repository_impl.dart';
import 'package:github_users_flutter/domain/entities/user_detail.dart';
import 'package:github_users_flutter/domain/entities/user_paged_item.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubRemoteDataSource extends Mock
    implements GithubRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late GitHubUserRepositoryImpl repository;
  late MockGithubRemoteDataSource mockGithubRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockGithubRemoteDataSource = MockGithubRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = GitHubUserRepositoryImpl(
      remoteDataSource: mockGithubRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const userDetailModel = UserDetailModel(
      id: 1,
      name: "octocat",
      avatarUrl: "https://github.com/images/error/octocat_happy.gif",
      publicRepos: 2,
      followers: 20,
      following: 0,
      html: "https://github.com/octocat",
      location: "San Francisco",
      displayName: "monalisa octocat",
      email: "octocat@github.com",
      bio: "There once was...");

  const UserDetail userDetail = userDetailModel;

  const userModel = UserModel(
      id: 1,
      name: "mojombo",
      avatarUrl:
      "https://secure.gravatar.com/avatar/25c7c18223fb42a4c6ae1c8db6f50f9b?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
      score: 1,
      html: "https://github.com/mojombo");
  const searchUserModel =
  SearchUserModel(totalCount: 1, items: [userModel]);
  const UserPagedItem userPagedItems = searchUserModel;

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  runTestOnline( () {
    group('getUserDetail', (){
      test(
          'should return remote data when the call to remote data source is success',
              () async {
            // arrange
            when(() => mockGithubRemoteDataSource.getUserDetail(any()))
                .thenAnswer((_) async => userDetailModel);

            //act
            final result = await repository.getUserDetail("userName");

            //assert
            verify(() => mockGithubRemoteDataSource.getUserDetail("userName"));
            expect(result, const Right(userDetail));
          });

      test(
          'should return ServerFailure when the call to remote data source is unsuccessful',
              () async {
            // arrange
            when(() => mockGithubRemoteDataSource.getUserDetail(any()))
                .thenThrow(ServerException());

            //act
            final result = await repository.getUserDetail("userName");

            //assert
            verify(() => mockGithubRemoteDataSource.getUserDetail("userName"));
            expect(result, equals(Left(ServerFailure())));
          });
    });

    group('searchUsers', (){
      test(
          'should return remote data when the call to remote data source is success',
              () async {
            // arrange
            when(() => mockGithubRemoteDataSource.searchUsers(any(), any()))
                .thenAnswer((_) async => searchUserModel);

            //act
            final result = await repository.searchUsers("userName", 1);

            //assert
            verify(() => mockGithubRemoteDataSource.searchUsers("userName", 1));
            expect(result, const Right(userPagedItems));
          });

      test(
          'should return ServerFailure when the call to remote data source is unsuccessful',
              () async {
            // arrange
            when(() => mockGithubRemoteDataSource.searchUsers(any(), any()))
                .thenThrow(ServerException());

            //act
            final result = await repository.searchUsers("userName", 1);

            //assert
            verify(() => mockGithubRemoteDataSource.searchUsers("userName", 1));
            expect(result, equals(Left(ServerFailure())));
          });
    });
  });

  runTestOffline( () {
    test('getUserDetail should return NetworkFailure', () async {
      // arrange
      when(() => mockGithubRemoteDataSource.getUserDetail(any()))
          .thenAnswer((_) async => userDetailModel);

      //act
      final result = await repository.getUserDetail("userName");

      //assert
      verifyNoMoreInteractions(mockGithubRemoteDataSource);
      expect(result, equals(Left(NetworkFailure())));
    });

    test('searchUsers should return NetworkFailure', () async {
      // arrange
      when(() => mockGithubRemoteDataSource.searchUsers(any(), any()))
          .thenAnswer((_) async => searchUserModel);

      //act
      final result = await repository.searchUsers("userName", 1);

      //assert
      verifyNoMoreInteractions(mockGithubRemoteDataSource);
      expect(result, equals(Left(NetworkFailure())));
    });
  });

}
