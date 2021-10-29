import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_users_flutter/core/failures.dart';
import 'package:github_users_flutter/domain/entities/user_paged_item.dart';
import 'package:github_users_flutter/domain/usecases/search_users.dart';
import 'package:github_users_flutter/presentation/bloc/search_users_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchUsers extends Mock implements SearchUsers {}

void main() {
  late SearchUsers mockUseCase;
  late SearchUsersBloc bloc;

  setUp(() {
    mockUseCase = MockSearchUsers();
    bloc = SearchUsersBloc(searchUsers: mockUseCase);
  });

  test('initialState should be [SearchEmpty]', () {
    //assert
    expect(bloc.state, equals(SearchEmpty()));
  });

  test('should emit [SearchEmpty] when search keyword is empty', () {
    // arrange
    const SearchUsersEvent textChanged = TextChanged(text: "");

    // act
    bloc.add(textChanged);

    // assert
    expect(bloc.state, equals(SearchEmpty()));
  });

  const dummySearch = "dummy";
  const searchParams = SearchUsersParam(dummySearch, 1);
  const userPagedItem = UserPagedItem([], 0);

  blocTest<SearchUsersBloc, SearchUsersState>(
      'should return [SearchError] when server error',
      setUp: () {
        when(() => mockUseCase(searchParams))
            .thenAnswer((_) async => Left(ServerFailure()));
      },
      build: () => SearchUsersBloc(searchUsers: mockUseCase),
      act: (blocA) => blocA.add(const TextChanged(text: dummySearch)),
      expect: () => [SearchLoading(), const SearchError(error: serverError)],
      wait: const Duration(milliseconds: 300),
      verify: (_) {
        verify(() => mockUseCase(searchParams));
      });

  blocTest<SearchUsersBloc, SearchUsersState>(
      'should return [SearchSuccess] when server return data successful',
      setUp: () {
        when(() => mockUseCase(searchParams))
            .thenAnswer((_) async => const Right(userPagedItem));
      },
      build: () => SearchUsersBloc(searchUsers: mockUseCase),
      act: (blocA) => blocA.add(const TextChanged(text: dummySearch)),
      expect: () => [SearchLoading(), const SearchSuccess(items: [])],
      wait: const Duration(milliseconds: 300),
      verify: (_) {
        verify(() => mockUseCase(searchParams));
      });
}
