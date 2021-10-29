import 'dart:convert';

import 'package:github_users_flutter/core/configs.dart';
import 'package:github_users_flutter/core/exceptions.dart';
import 'package:github_users_flutter/data/models/user_detail_model.dart';
import 'package:github_users_flutter/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class GithubRemoteDataSource {
  Future<SearchUserModel> searchUsers(String keywords, int page);

  Future<UserDetailModel> getUserDetail(String userName);
}

class GitHubRemoteDataSourceImpl implements GithubRemoteDataSource {
  final http.Client client;
  final BASE_URL = "https://api.github.com";

  GitHubRemoteDataSourceImpl(this.client);

  @override
  Future<UserDetailModel> getUserDetail(String userName) async {
    final url = Uri.parse('$BASE_URL/$userName');
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return UserDetailModel.fromJson(json.decode(response.body));
  }

  @override
  Future<SearchUserModel> searchUsers(String keywords, int page) async {
    final queryParams = {
      'q': keywords,
      'page': page.toString(),
      'per_page': itemPerPage.toString()
    };

    String queryString = Uri(queryParameters: queryParams).query;
    final url = Uri.parse('$BASE_URL/search/users?$queryString');
    final response =
        await client.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return SearchUserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
