import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_users_flutter/data/models/user_detail_model.dart';
import 'package:github_users_flutter/domain/entities/user_detail.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
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
      bio: "There once was..."
  );

  test('should be a subclass of UserDetail', () async {
    //assert
    expect(userDetailModel, isA<UserDetail>());
  });

  group('fromJson', () {
    test('should return valid UserDetailModel', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('user_detail.json'));

      //act
      final result = UserDetailModel.fromJson(jsonMap);

      //assert
      expect(result, userDetailModel);
    });
  });
}
