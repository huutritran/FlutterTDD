import 'package:flutter/material.dart';
import 'package:github_users_flutter/presentation/pages/search/search_bar.dart';
import 'package:github_users_flutter/presentation/pages/search/search_body.dart';

class SearchUsersPage extends StatelessWidget {
  const SearchUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        SearchBar(),
        SearchBody(),
      ],
    );
  }
}