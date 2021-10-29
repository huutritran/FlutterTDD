import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_users_flutter/data/models/user_model.dart';
import 'package:github_users_flutter/domain/entities/user.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const userModel = UserModel(
      id: 1,
      name: "mojombo",
      avatarUrl:
      "https://secure.gravatar.com/avatar/25c7c18223fb42a4c6ae1c8db6f50f9b?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
      score: 1,
      html: "https://github.com/mojombo");
  const searchUserModel =
  SearchUserModel(totalCount: 1, items: [userModel]);

  test('should be a subclass of User', () async {
    //assert
    expect(userModel, isA<User>());
  });

  group('fromJson', () {

    test('should return valid UserModel', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
      json.decode(fixture('user.json'));

      //act
      final result = UserModel.fromJson(jsonMap);

      //assert
      expect(result, userModel);
    });

    test(
      'should return valid SearchUserModel',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('search_user.json'));

        //act
        final result = SearchUserModel.fromJson(jsonMap);

        //assert
        expect(result.totalCount, searchUserModel.totalCount);
        expect(result.items, searchUserModel.items);
      },
    );
  });
}
