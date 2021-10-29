import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_users_flutter/domain/entities/user_detail.dart';
import 'package:github_users_flutter/domain/repositories/github_user_repository.dart';
import 'package:github_users_flutter/domain/usecases/get_user_detail.dart';
import 'package:mocktail/mocktail.dart';

class MockGitHubUserRepository extends Mock implements GitHubUserRepository {}

void main() {
  late GitHubUserRepository mockRepository;
  late GetUserDetail usecase;

  setUp(() {
    mockRepository = MockGitHubUserRepository();
    usecase = GetUserDetail(mockRepository);
  });

  test(
    'should get user detail from the repository',
    () async {
      //arrange
      const userDetail = UserDetail(
          id: 1,
          name: "name",
          avatarUrl: "avatarUrl",
          publicRepos: 1,
          followers: 1,
          following: 1,
          html: "html");
      when(() => mockRepository.getUserDetail(any()))
          .thenAnswer((_) async => const Right(userDetail));

      //act
      final result = await usecase(GetUserDetailParams("username"));

      //assert
      expect(result, const Right(userDetail));
      verify(() => mockRepository.getUserDetail("username"));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
