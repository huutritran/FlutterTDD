import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_users_flutter/domain/entities/user.dart';
import 'package:github_users_flutter/domain/entities/user_paged_item.dart';
import 'package:github_users_flutter/domain/repositories/github_user_repository.dart';
import 'package:github_users_flutter/domain/usecases/search_users.dart';
import 'package:mocktail/mocktail.dart';

class MockGitHubUserRepository extends Mock implements GitHubUserRepository {}

void main() {
  late GitHubUserRepository mockRepository;
  late SearchUsers usecase;

  setUp(() {
    mockRepository = MockGitHubUserRepository();
    usecase = SearchUsers(mockRepository);
  });

  test(
    'should get users from the repository',
    () async {
      //arrange
      const users = [
        User(
            id: 1, name: "name", avatarUrl: "avatarUrl", score: 1, html: "html")
      ];
      final userPagedItem = UserPagedItem(users, users.length);
      when(() => mockRepository.searchUsers(any(), any()))
          .thenAnswer((_) async => Right(userPagedItem));

      //act
      final result = await usecase(SearchUsersParam("keywords", 1));

      //assert
      expect(result, Right(userPagedItem));
      verify(() => mockRepository.searchUsers("keywords", 1));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
