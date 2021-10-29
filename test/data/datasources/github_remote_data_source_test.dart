import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_users_flutter/core/configs.dart';
import 'package:github_users_flutter/core/exceptions.dart';
import 'package:github_users_flutter/data/datasources/github_user_remote_data_source.dart';
import 'package:github_users_flutter/data/models/user_detail_model.dart';
import 'package:github_users_flutter/data/models/user_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late GithubRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    registerFallbackValue(Uri());
    mockHttpClient = MockHttpClient();
    dataSource = GitHubRemoteDataSourceImpl(mockHttpClient);
  });

  group('getUserDetail', () {
    const userName = "userName";

    test('should perform a GET request with userName being the endpoint',
        () async {
      //arrange
      when(() => mockHttpClient
              .get(any(), headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (_) async => http.Response(fixture('user_detail.json'), 200));

      //act
      await dataSource.getUserDetail(userName);

      //assert
      verify(() => mockHttpClient.get(
          Uri.parse('https://api.github.com/$userName'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return UserDetailModel when response code is 200', () async {
      //arrange
      final userDetailModel =
          UserDetailModel.fromJson(json.decode(fixture('user_detail.json')));
      when(() => mockHttpClient
              .get(any(), headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (_) async => http.Response(fixture('user_detail.json'), 200));

      //act
      final result = await dataSource.getUserDetail(userName);

      //assert
      expect(result, equals(userDetailModel));
    });

    test('should return UserDetailModel when response code is 404 or other',
        () async {
      //arrange
      when(() => mockHttpClient
              .get(any(), headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      //act
      final call = dataSource.getUserDetail;

      //assert
      expect(
          () => call(userName), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('searchUsers', () {
    const keywords = "keywords";
    const page = 1;

    test('should perform a GET request with userName being the endpoint',
        () async {
      //arrange
      when(() => mockHttpClient
              .get(any(), headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (_) async => http.Response(fixture('search_user.json'), 200));

      //act
      await dataSource.searchUsers(keywords, page);
      //assert
      verify(() => mockHttpClient.get(
          Uri.parse(
              'https://api.github.com/search/users?q=$keywords&page=$page&per_page=$itemPerPage'),
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return UserDetailModel when response code is 200', () async {
      //arrange
      final searchUserModel =
          SearchUserModel.fromJson(json.decode(fixture('search_user.json')));
      when(() => mockHttpClient
              .get(any(), headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (_) async => http.Response(fixture('search_user.json'), 200));

      //act
      final result = await dataSource.searchUsers(keywords, page);

      //assert
      expect(result, equals(searchUserModel));
    });

    test('should return UserDetailModel when response code is 404 or other',
        () async {
      //arrange
      when(() => mockHttpClient
              .get(any(), headers: {'Content-Type': 'application/json'}))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      //act
      final call = dataSource.searchUsers;

      //assert
      expect(
          () => call(keywords, page), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
